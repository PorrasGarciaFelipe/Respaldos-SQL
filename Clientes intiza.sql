
select * from CvClientes
where IdProyecto=21

SELECT * FROM CvVendedores


select CvClientes.Cliente,CvClientes.Nombre,CvClientes.ApellidoPaterno,CvClientes.ApellidoMaterno,CvClientes.Email,CvClientes.TelefonoCelular,CvVendedores.nombre Asesor 
from CvClientes inner join CvVendedores on CvClientes.Vendedor1 =CvVendedores.IdVendedor
where IdProyecto=18
