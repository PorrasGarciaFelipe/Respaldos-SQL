


select * from AoDestajosEst

select * from AoDestajosEstDet

select * from AoDestajosEstCC

select centro from Centros
where idCentro=234

Select * from Centros
where idProyecto=24

select * from AoCatConceptos

select * from AcExplosionInsumos

select * from AcCatInsumos
where Insumo like '%ACAEXH009%'

select * from AcAlmacenConsecutivo

SELECT * FROM AcExplosionInsumos
WHERE idInsumo=7219


SELECT * FROM AoPresupuestoControl
WHERE IdProyecto=15 and idConcepto =1181
 

select t7.Partida, t2.idconcepto,t1.idInsumo, t1.Insumo,t1.Descripcion, t3.Unidad,t6.Destajista
from AcCatInsumos t1 
inner join AoCatConceptos t2 on t1.DescripcionLarga like t2.DescripcionLarga
inner join AcCatUnidades t3 on t1.idUnidad=t3.IdUnidad
inner join AoPresupuestoControl t4 on t4.idConcepto=t2.idConcepto
inner join AoConceptosXDestajista t5 on t5.IdPresupuestoControl= t4.IdPresupuestoControl
inner join AoCatDestajistas t6 on t6.idDestajista=t5.idDestajista
inner join AoPartidas t7 on t7.IdPartida=t4.idPartida
where t2.idProyecto in (select idProyecto from Proyectos where Proyecto like '%5a-3a%') and t1.Insumo like '%pmbho8002%'
order by t7.Partida

/*******************************************************************************/
select *
from AcPedidos
where idProyecto in (select idProyecto from Proyectos where Proyecto like '%encata%') and Pedido = 447

SELECT * from AcAlmacenEntradas
where idProyecto in (select idProyecto from Proyectos where Proyecto like '%5a-2a%') 
and idPedido in(select idpedido from AcPedidos where Pedido=579)

update AcAlmacenEntradas
set Importe=1157.32
where idProyecto in (select idProyecto from Proyectos where Proyecto like '%5a-2a%') 
and idPedido in(select idpedido from AcPedidos where Pedido=579)



select idAlmacenEntradaDet,t3.Insumo, t3.Descripcion,Cantidad, 
t1.Costo, (Cantidad*t1.Costo )as importe
from AcAlmacenEntradasDet t1
inner join AcExplosionInsumos t2 on t1.idExplosionInsumos=t2.idExplosionInsumos
inner join AcCatInsumos t3 on t2.idInsumo=t3.idInsumo
where idAlmacenEntrada 
in(select idalmacenentrada from acalmacenentradas 
	where idPedido in(select IdPedido from AcPedidos 
		where Pedido=579
		and idRequisicion 
			in (select idrequisicion from acrequisiciones 
			where requisicion=276) 
		and idProyecto 
			in (select idProyecto from Proyectos 
			where Proyecto like '%5a-2a%')))

update AcAlmacenEntradasDet
set Costo=11.519
where idAlmacenEntradaDet=11662

/*******************************************************************************/

select * from AcCatInsumos
where DescripcionLarga like '%tee pvc hi%'