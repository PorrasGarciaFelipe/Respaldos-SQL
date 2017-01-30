
WITH DESTAJOS ( idinsumo,CONCEPTO, UBICACION, DESCRIPCIÓN, UNIDAD, COSTO, CANTIDAD) AS(
select t1.idinsumo, T1.INSUMO AS concepto, t8.Centro as centro, t1.Descripcion as descripcións, t3.Unidad as Unidads,t6.Costo, t7.Cantidad
from AcCatInsumos t1
inner join AoCatConceptos t2 on t1.DescripcionLarga like t2.DescripcionLarga
inner join AcCatUnidades t3 on t1.idUnidad=t3.IdUnidad
inner join Proyectos t4 on t2.idProyecto= t4.IdProyecto
inner join AoPresupuestoControl t5 on t5.idConcepto = t2.idConcepto
inner join AoPartidas t11 on t11.IdPartida = t5.idPartida
inner join AoDestajosEstDet t6 on t5.IdPresupuestoControl=t6.IdPresupuestoControl
inner join AoDestajosEstCC t7 on t6.IdDestajoDet = t7.IdDestajoDet
inner join Centros t8 on t8.idCentro = t7.idCentro 
where t2.idProyecto in (select idProyecto from Proyectos where Proyecto like '%5a-3a%') and Centro like '%27A0%'
group by t1.idinsumo,T1.INSUMO , t1.Descripcion , t8.Centro , t3.Unidad ,t6.Costo, t7.Cantidad
)SELECT * FROM DESTAJOS
PIVOT (sum(cantidad) for
ubicacion in ([27A01],[27A02],[27A03],[27A04],[27A05],[27A06],[27A07],[27A08])) PVT
ORDER BY CONCEPTO


SELECT * FROM AoDestajosEst