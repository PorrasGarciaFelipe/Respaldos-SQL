

DECLARE @cols AS NVARCHAR(MAX)
Declare @query  AS nVARCHAR(max)

SELECT @cols = STUFF((SELECT  ',' + QUOTENAME(INSUMO) 
                    FROM AcCatInsumos
	                  where Insumo like '%PAQ%'
            FOR XML PATH(''), TYPE ).value('.', 'NVARCHAR(MAX)'),1,1,'')
            
select @query='
WITH DESTAJOS (CONCEPT, UBICACION, CANTIDAD) AS(
select DISTINCT i1.INSUMO, t9.Centro,sum(t1.Cantidad) 
from accatinsumos i1 
inner join AoCatConceptos i2 on i1.DescripcionLarga like i2.DescripcionLarga
inner join AcCatUnidades u1 on i1.IdUnidad=u1.idUnidad
inner join Proyectos i3 on i2.IdProyecto=i3.idProyecto
inner join AoPresupuestoControl t5 on i2.idConcepto=t5.idConcepto
inner join AoDestajosEstDet t2 on t5.IdPresupuestoControl=t2.IdPresupuestoControl
inner join AoDestajosEstCC t1 on t2.IdDestajoDet=t1.IdDestajoDet
inner join Centros t9 on t1.idCentro=t9.idCentro
where t9.idProyecto in (select idProyecto from Proyectos where idproyecto=20) and t9.idcentro between 607 and 614 
and i2.idproyecto=20
group by i1.INSUMO, t9.Centro, i1.Descripcion, u1.Unidad, t1.Cantidad
)SELECT * FROM DESTAJOS
PIVOT (SUM(CANTIDAD) for
CONCEPT in ('+ @cols +')) PVT
ORDER BY UBICACION'
EXEC SP_EXECUTESQL @query




select * from Proyectos
where Proyecto like '%5a-3%'
select * from Centros 
where idProyecto = 20


select * from Centros
where Centro like '%27A0%

select * from aocatconceptos