/*Cantidad*/
DECLARE @cols AS NVARCHAR(MAX)
Declare @query  AS nVARCHAR(max)
declare @idCentro As varchar(max)
declare @idEstimacion as nvarchar(max)             
declare @Cantidad as nvarchar(max)             
SELECT @Cantidad=COALESCE(@Cantidad+', ', '')+cast(Cantidad as varchar(max))
                    FROM AoDestajosEstCC                    
                    where IdDestajoDet in (select IdDestajoDet from AoDestajosEstDet where IdDestajoEst in(select IdDestajoEst 
                    from AoDestajosEst where idProyecto in(select idProyecto from Proyectos where Proyecto like '%6a-1a%' and  Nombre like 'lomas%')
                    and DATENAME(yy, Fecha)='2017' AND DATENAME(dd, fecha)='12'))
SELECT @idCentro=COALESCE(@idCentro+', ', '')+cast(idCentro as varchar(max))
                    FROM AoDestajosEstCC                    
                    where IdDestajoDet in (select IdDestajoDet from AoDestajosEstDet where IdDestajoEst in(select IdDestajoEst 
                    from AoDestajosEst where idProyecto in(select idProyecto from Proyectos where Proyecto like '%6a-1a%' and  Nombre like 'lomas%')
                    and DATENAME(yy, Fecha)='2017' AND DATENAME(dd, fecha)='12'))
                   
SELECT distinct @cols = STUFF((SELECT distinct ',' + QUOTENAME(t1.Centro) 
		from Centros t1
inner join AoDestajosEstCC t2 on t2.idCentro=t1.idCentro
where t2.IdDestajoDet in (select IdDestajoDet from AoDestajosEstDet
						where IdDestajoEst in (select IdDestajoEst from AoDestajosEst
							where IdProyecto in (select idProyecto from Proyectos where Proyecto like '%6a-1a%') 
							and DATENAME(yy, Fecha)='2017' AND DATENAME(dd, fecha)='12'))
					    FOR XML PATH(''), TYPE ).value('.', 'NVARCHAR(MAX)'),1,1,'')
select @query=
'WITH DESTAJOS (PROYECTO,CONCEPTO, UBICACION, DESCRIPCIÓN, UNIDAD,CANTIDAD) AS(
select I3.Proyecto,i1.INSUMO, t9.Centro, i1.Descripcion, u1.Unidad,t1.Cantidad 
from accatinsumos i1 
inner join AoCatConceptos i2 on i1.DescripcionLarga like i2.DescripcionLarga
inner join AcCatUnidades u1 on i1.IdUnidad=u1.idUnidad
inner join Proyectos i3 on i2.IdProyecto=i3.idProyecto
inner join AoPresupuestoControl t5 on i2.idConcepto=t5.idConcepto
inner join AoDestajosEstDet t2 on t5.IdPresupuestoControl=t2.IdPresupuestoControl
inner join AoDestajosEstCC t1 on t2.IdDestajoDet=t1.IdDestajoDet
inner join Centros t9 on t1.idCentro=t9.idCentro
where t1.idcentro in ('+@idCentro+')
group by i1.INSUMO, t9.Centro, i1.Descripcion, u1.Unidad, t1.Cantidad, i3.proyecto, t1.iddestajoestCC
)SELECT * FROM DESTAJOS
PIVOT (SUM(CANTIDAD) for
ubicacion in ('+ @cols +'))PVT
ORDER BY proyecto'
EXEC SP_EXECUTESQL @query




