/*Cantidad*/
DECLARE @cols AS NVARCHAR(MAX)
Declare @query  AS nVARCHAR(max)
declare @idCentro As varchar(max)
declare @idEstimacion as nvarchar(max)                    
SELECT top 6 @idEstimacion=COALESCE(@idEstimacion+', ', '')+cast(IdDestajoEst as varchar(max))
                    FROM AoDestajosEst
                    where /*centro like '%29%' and*/ idProyecto in (select idProyecto from Proyectos where Proyecto like '%6a-1a%')
SELECT @idCentro = COALESCE(@idcentro+', ', '')+cast(idcentro as nvarchar(max))
                    FROM Centros
                    where /*centro like '%29%' and*/ idProyecto in (select idProyecto from Proyectos where Proyecto like '%6a-1a%')
SELECT @cols = STUFF((SELECT  ',' + QUOTENAME(centro) 
                    FROM Centros
                    where /*centro like '%29%' and*/ idProyecto in(select idProyecto from Proyectos where Proyecto like '%6a-1a%')
                    FOR XML PATH(''), TYPE ).value('.', 'NVARCHAR(MAX)'),1,1,'')
            
select @query=
'WITH DESTAJOS (CONCEPTO, UBICACION, DESCRIPCIÓN, UNIDAD, CANTIDAD) AS(
select DISTINCT i1.INSUMO, t9.Centro, i1.Descripcion, u1.Unidad,sum(t1.Cantidad) 
from accatinsumos i1 
inner join AoCatConceptos i2 on i1.DescripcionLarga like i2.DescripcionLarga
inner join AcCatUnidades u1 on i1.IdUnidad=u1.idUnidad
inner join Proyectos i3 on i2.IdProyecto=i3.idProyecto
inner join AoPresupuestoControl t5 on i2.idConcepto=t5.idConcepto
inner join AoDestajosEstDet t2 on t5.IdPresupuestoControl=t2.IdPresupuestoControl
inner join AoDestajosEstCC t1 on t2.IdDestajoDet=t1.IdDestajoDet
inner join aodestajosEst p2 on p2.iddestajoest=t2.iddestajoest
inner join Centros t9 on t1.idCentro=t9.idCentro
where /*t9.idProyecto=20 
	and */t9.idcentro in('+@idCentro+') and p2.idDestajoEst in('+@idEstimacion+') and t1.cantidad>0
group by i1.INSUMO, t9.Centro, i1.Descripcion, u1.Unidad, t1.Cantidad
)SELECT * FROM DESTAJOS
PIVOT (SUM(CANTIDAD) for
ubicacion in ('+ @cols +'))PVT
ORDER BY CONCEPTO'
EXEC SP_EXECUTESQL @query


/**/


select * from AoDestajosEst
where IdProyecto in (select IdProyecto from Proyectos where Proyecto like '%6a-1a%')


/*COSTO*/
DECLARE @cols1 AS NVARCHAR(MAX)
Declare @query1  AS nVARCHAR(max)
declare @idCentro1 As varchar(max)

SELECT @idCentro1 = COALESCE(@idcentro1+', ', '')+cast(idcentro as nvarchar(max))
                    FROM Centros
                    where centro like '%99%' and idProyecto=20
SELECT @cols1 = STUFF((SELECT  ',' + QUOTENAME(centro) 
                    FROM Centros
                    where centro like '%99%' and idProyecto=20
                    FOR XML PATH(''), TYPE ).value('.', 'NVARCHAR(MAX)'),1,1,'')
            
select @query1=
'WITH DESTAJOS (CONCEPTO, UBICACION, DESCRIPCIÓN, UNIDAD, COSTO) AS(
select DISTINCT i1.INSUMO, t9.Centro, i1.Descripcion, u1.Unidad,AVG(t2.Costo) 
from accatinsumos i1 
inner join AoCatConceptos i2 on i1.DescripcionLarga like i2.DescripcionLarga
inner join AcCatUnidades u1 on i1.IdUnidad=u1.idUnidad
inner join Proyectos i3 on i2.IdProyecto=i3.idProyecto
inner join AoPresupuestoControl t5 on i2.idConcepto=t5.idConcepto
inner join AoDestajosEstDet t2 on t5.IdPresupuestoControl=t2.IdPresupuestoControl
inner join AoDestajosEstCC t1 on t2.IdDestajoDet=t1.IdDestajoDet
inner join aodestajosEst p2 on p2.iddestajoest=t2.iddestajoest
inner join Centros t9 on t1.idCentro=t9.idCentro
where /*t9.idProyecto=20 
	and */t9.idcentro in('+@idCentro1+') /*and p2.fecha like 2017-01-05*/
group by i1.INSUMO, t9.Centro, i1.Descripcion, u1.Unidad, t1.Cantidad
)SELECT * FROM DESTAJOS
PIVOT (AVG(COSTO) for
ubicacion in ('+ @cols1 +'))PVT
ORDER BY CONCEPTO'
EXEC SP_EXECUTESQL @query1



declare @feed as nvarchar(max)
SELECT @feed = STUFF((SELECT  ',' + QUOTENAME(FechaFin)
                    FROM AoDestajosEst
                    where idProyecto in(select idProyecto from Proyectos where Proyecto like '%6a-1a%')
                    FOR XML PATH(''), TYPE ).value('.', 'nVARCHAR(MAX)'),1,1,'')
                    EXEC SP_EXECUTESQL @feed
                    
                    
declare @idEstimacion as nvarchar(max)                    
        SELECT top 10 @idEstimacion=COALESCE(@idEstimacion+', ', '')+cast(IdDestajoEst as varchar(max))
                    FROM AoDestajosEst
                    where /*centro like '%29%' and*/ idProyecto in (select idProyecto from Proyectos where Proyecto like '%6a-1a%')
EXEC SP_EXECUTESQL @idestimacion                    

declare @idcentro as nvarchar(max)
SELECT @idCentro = COALESCE(@idcentro+', ', '')+cast(idcentro as nvarchar(max))
                    FROM Centros
                    where /*centro like '%29%' and*/ idProyecto in (select idProyecto from Proyectos where Proyecto like '%6a-1a%')
EXEC SP_EXECUTESQL @idcentro                    
