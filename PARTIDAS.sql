/*Cantidad*/
DECLARE @cols AS NVARCHAR(MAX)
Declare @query  AS nVARCHAR(max)
declare @idCentro As varchar(max)
declare @idEstimacion as nvarchar(max)         
SELECT top 3 @idEstimacion=COALESCE(@idEstimacion+', ', '')+cast(IdDestajoEst as varchar(max))
                    FROM AoDestajosEst
                    where /*centro like '%99%' and*/ idProyecto in (select idProyecto from Proyectos where Proyecto like '%6a-1a%')
                    order by IdDestajoEst desc
SELECT @idCentro = COALESCE(@idcentro+', ', '')+cast(idcentro as nvarchar(max))
                    /*FROM Centros
                    where centro like '%99%' and idProyecto in (select idProyecto from Proyectos where Proyecto like '%6a-1a%') 
                    */
                    from AoDestajosEstCC
where IdDestajoDet in (select IdDestajoDet from AoDestajosEstDet
						where IdDestajoEst in (select top 3 IdDestajoEst from AoDestajosEst
							where IdProyecto in (select IdProyecto from Proyectos where Proyecto 
								like '%6a-1a%') 
						order by IdDestajoEst desc))
                    
SELECT @cols = STUFF((SELECT distinct ',' + QUOTENAME(t1.centro) 
	from Centros t1
inner join AoDestajosEstCC t2 on t2.idCentro=t1.idCentro
where t2.IdDestajoDet in (select IdDestajoDet from AoDestajosEstDet
						where IdDestajoEst in (select top 3 IdDestajoEst from AoDestajosEst
							where IdProyecto in (select IdProyecto from Proyectos where Proyecto 
								like '%6a-1a%') 
						order by IdDestajoEst desc))
						/*order by Centro asc
/                    FROM Centros
                    where/* centro like '%99%' and*/ idProyecto in(select idProyecto from Proyectos where Proyecto like '%6a-1a%')*/
                    FOR XML PATH(''), TYPE ).value('.', 'NVARCHAR(MAX)'),1,1,'')
            
select @query=
'WITH DESTAJOS (PARTIDA, CONCEPTO, UBICACION, DESCRIPCIÓN, UNIDAD, FECHA,CANTIDAD) AS(
select DISTINCT t10.Descripcion ,i1.INSUMO, t9.Centro, i1.Descripcion, u1.Unidad,P2.FECHA,sum(t1.Cantidad) 
from accatinsumos i1 
inner join AoCatConceptos i2 on i1.DescripcionLarga like i2.DescripcionLarga
inner join AcCatUnidades u1 on i1.IdUnidad=u1.idUnidad
inner join Proyectos i3 on i2.IdProyecto=i3.idProyecto
inner join AoPresupuestoControl t5 on i2.idConcepto=t5.idConcepto
inner join AoDestajosEstDet t2 on t5.IdPresupuestoControl=t2.IdPresupuestoControl
inner join AoDestajosEstCC t1 on t2.IdDestajoDet=t1.IdDestajoDet
inner join aodestajosEst p2 on p2.iddestajoest=t2.iddestajoest
inner join Centros t9 on t1.idCentro=t9.idCentro
inner join AoPartidas t10 on t10.IdPartida = t5.idPartida
where /*t9.idProyecto=20 
	and */t9.idcentro in('+@idCentro+') and p2.idDestajoEst in('+@idEstimacion+') and t1.cantidad>0
group by i1.INSUMO, t9.Centro, i1.Descripcion, u1.Unidad, t1.Cantidad, t10.Descripcion, P2.FECHA
)SELECT * FROM DESTAJOS
PIVOT (SUM(CANTIDAD) for
ubicacion in ('+ @cols +'))PVT
ORDER BY fecha desc'
EXEC SP_EXECUTESQL @query


/*COSTO*/
DECLARE @cols1 AS NVARCHAR(MAX)
Declare @query1  AS nVARCHAR(max)
declare @idCentro1 As varchar(max)
declare @idEstimacion1 as nvarchar(max)                    
SELECT top 4 @idEstimacion1=COALESCE(@idEstimacion1+', ', '')+cast(IdDestajoEst as varchar(max))
                    FROM AoDestajosEst
                    where /*centro like '%99%' and*/ idProyecto in (select idProyecto from Proyectos where Proyecto like '%6a-1a%')
                    order by IdDestajoEst desc
SELECT @idCentro1 = COALESCE(@idcentro1+', ', '')+cast(idcentro as nvarchar(max))
                    FROM Centros
                    where centro like '%99%' and idProyecto in (select idProyecto from Proyectos where Proyecto like '%6a-1a%')
SELECT @cols1 = STUFF((SELECT  ',' + QUOTENAME(centro) 
                    FROM Centros
                    where centro like '%99%' and idProyecto in(select idProyecto from Proyectos where Proyecto like '%6a-1a%')
                    FOR XML PATH(''), TYPE ).value('.', 'NVARCHAR(MAX)'),1,1,'')
            
select @query1=
'WITH DESTAJOS (PARTIDA, CONCEPTO, UBICACION, DESCRIPCIÓN, UNIDAD,FECHA, COSTO) AS(
select DISTINCT t10.Descripcion, i1.INSUMO, t9.Centro, i1.Descripcion, p2.fecha,u1.Unidad,AVG(t2.Costo) 
from accatinsumos i1 
inner join AoCatConceptos i2 on i1.DescripcionLarga like i2.DescripcionLarga
inner join AcCatUnidades u1 on i1.IdUnidad=u1.idUnidad
inner join Proyectos i3 on i2.IdProyecto=i3.idProyecto
inner join AoPresupuestoControl t5 on i2.idConcepto=t5.idConcepto
inner join AoDestajosEstDet t2 on t5.IdPresupuestoControl=t2.IdPresupuestoControl
inner join AoDestajosEstCC t1 on t2.IdDestajoDet=t1.IdDestajoDet
inner join aodestajosEst p2 on p2.iddestajoest=t2.iddestajoest
inner join Centros t9 on t1.idCentro=t9.idCentro
inner join AoPartidas t10 on t10.IdPartida = t5.idPartida
where /*t9.idProyecto=20 
	and */t9.idcentro in('+@idCentro1+') and p2.idDestajoEst in('+@idEstimacion1+') and t1.cantidad>0
group by i1.INSUMO, t9.Centro, i1.Descripcion, u1.Unidad, t2.COSTO, t10.Descripcion, p2.fecha
)SELECT * FROM DESTAJOS
PIVOT (AVG(Costo) for
ubicacion in ('+ @cols1 +'))PVT
ORDER BY PARTIDA'
EXEC SP_EXECUTESQL @query1




/*IMPORTES*/
DECLARE @cols2 AS NVARCHAR(MAX)
Declare @query2  AS nVARCHAR(max)
declare @idCentro2 As varchar(max)
declare @idEstimacion2 as nvarchar(max)                    
SELECT top 4 @idEstimacion2=COALESCE(@idEstimacion2+', ', '')+cast(IdDestajoEst as varchar(max))
                    FROM AoDestajosEst
                    where /*centro like '%99%' and*/ idProyecto in (select idProyecto from Proyectos where Proyecto like '%6a-1a%')
                    order by IdDestajoEst desc
SELECT @idCentro2 = COALESCE(@idcentro2+', ', '')+cast(idcentro as nvarchar(max))
                    FROM Centros
                    where centro like '%99%' and idProyecto in (select idProyecto from Proyectos where Proyecto like '%6a-1a%')
SELECT @cols2 = STUFF((SELECT  ',' + QUOTENAME(centro) 
                    FROM Centros
                    where centro like '%99%' and idProyecto in(select idProyecto from Proyectos where Proyecto like '%6a-1a%')
                    FOR XML PATH(''), TYPE ).value('.', 'NVARCHAR(MAX)'),1,1,'')
            
select @query2=
'WITH DESTAJOS (PARTIDA, CONCEPTO, UBICACION, DESCRIPCIÓN, UNIDAD,FECHA, COSTO) AS(
select DISTINCT t10.Descripcion ,i1.INSUMO, t9.Centro, i1.Descripcion, u1.Unidad,P2.FECHA,(T1.CANTIDAD*T2.COSTO) AS COSTO 
from accatinsumos i1 
inner join AoCatConceptos i2 on i1.DescripcionLarga like i2.DescripcionLarga
inner join AcCatUnidades u1 on i1.IdUnidad=u1.idUnidad
inner join Proyectos i3 on i2.IdProyecto=i3.idProyecto
inner join AoPresupuestoControl t5 on i2.idConcepto=t5.idConcepto
inner join AoDestajosEstDet t2 on t5.IdPresupuestoControl=t2.IdPresupuestoControl
inner join AoDestajosEstCC t1 on t2.IdDestajoDet=t1.IdDestajoDet
inner join aodestajosEst p2 on p2.iddestajoest=t2.iddestajoest
inner join Centros t9 on t1.idCentro=t9.idCentro
inner join AoPartidas t10 on t10.IdPartida = t5.idPartida
where /*t9.idProyecto=20 
	and */t9.idcentro in('+@idCentro2+') and p2.idDestajoEst in('+@idEstimacion2+') and t1.cantidad>0
group by i1.INSUMO, t9.Centro, i1.Descripcion, u1.Unidad, t2.COSTO, t10.Descripcion, T1.CANTIDAD, P2.FECHA
)SELECT * FROM DESTAJOS
PIVOT (AVG(Costo) for
ubicacion in ('+ @cols2 +'))PVT
ORDER BY PARTIDA'
EXEC SP_EXECUTESQL @query2	



select * from AoDestajosEstCC

select * from AoDestajosEstCC
where IdDestajoDet in (select IdDestajoDet from AoDestajosEstDet
						where IdDestajoEst in (select top 3 IdDestajoEst from AoDestajosEst
							where IdProyecto in (select IdProyecto from Proyectos where Proyecto 
								like '%6a-1a%') 
						order by IdDestajoEst desc))

/*
SELECT * FROM AoDestajosEst
WHERE IdProyecto = (SELECT IdProyecto FROM Proyectos WHERE Proyecto  LIKE '%6A-1A%')
ORDER BY Fecha DESC*/

select distinct t1.centro 
from Centros t1
inner join AoDestajosEstCC t2 on t2.idCentro=t1.idCentro
where t2.IdDestajoDet in (select IdDestajoDet from AoDestajosEstDet
						where IdDestajoEst in (select top 3 IdDestajoEst from AoDestajosEst
							where IdProyecto in (select IdProyecto from Proyectos where Proyecto 
								like '%6a-1a%') 
						order by IdDestajoEst desc))
						order by Centro asc
						
						
						
						
						