from diagrams import Cluster, Diagram
from diagrams.c4 import Person, Container, Database, SystemBoundary

graph_attr = {
	"ranksep": "2.0",
	"compound": "true"
}

with Diagram("Hadoop + Hive", direction="TB", show=False, graph_attr=graph_attr):
	# Usuario principal (Administradores o sistemas que interactúan con Hadoop)
	users = Person('Usuarios')

	# Sistema principal Hadoop
	with SystemBoundary("Hadoop Cluster"):

		# Sistema HDFS
		with Cluster("HDFS Layer"):
			namenode = Container(
				name="Namenode",
				technology="Hadoop HDFS",
				description="Administra el sistema de archivos distribuido.",
			)
			datanode1 = Container(
				name="Datanode 1",
				technology="Hadoop HDFS",
				description="Almacena los bloques de datos.",
			)
			datanode2 = Container(
				name="Datanode 2",
				technology="Hadoop HDFS",
				description="Almacena los bloques de datos.",
			)

		# Sistema YARN
		with Cluster("YARN Layer"):
			resourcemanager = Container(
				name="Resource Manager",
				technology="Hadoop YARN",
				description="Gestiona los recursos de los contenedores.",
			)
			nodemanager = Container(
				name="Node Manager",
				technology="Hadoop YARN",
				description="Gestiona los nodos de trabajo.",
			)
			historyserver = Container(
				name="History Server",
				technology="Hadoop YARN",
				description="Almacena el historial de las tareas YARN.",
			)

		# Sistema Hive
		with Cluster("Hive Layer"):
			hiveserver = Container(
				name="HiveServer",
				technology="HiveServer2",
				description="Gestiona las consultas de Hive.",
			)
			metastore = Container(
				name="Hive Metastore",
				technology="Hive Metastore",
				description="Almacena los metadatos de Hive.",
			)
			metastore_db = Database(
				name="Metastore DB",
				technology="PostgreSQL",
				description="Base de datos para el metastore de Hive.",
			)

	# Relaciones entre servicios

	# Usuarios >> Frontend
	users >> namenode
	users >> resourcemanager
	users >> hiveserver

	# Hadoop HDFS (Namenode y Datanodes)
	namenode >> datanode1
	namenode >> datanode2

	# YARN (Resource Manager y Node Manager)
	resourcemanager >> nodemanager
	resourcemanager >> historyserver

	# Hive (HiveServer y Metastore)
	hiveserver >> metastore
	metastore >> metastore_db

	# Relación entre servicios de Hadoop
	namenode >> resourcemanager  # Resource Manager necesita acceso al Namenode
	nodemanager >> resourcemanager  # NodeManager comunica con Resource Manager
	historyserver >> resourcemanager  # HistoryServer comunica con Resource Manager
	hiveserver >> metastore  # HiveServer interactúa con Hive Metastore
	metastore >> metastore_db  # Hive Metastore usa Metastore DB para persistir datos
