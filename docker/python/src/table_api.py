from pyflink.table import EnvironmentSettings, TableDescriptor, Schema, DataTypes, TableEnvironment
from pyflink.table.expressions import col

env_settings = EnvironmentSettings.in_streaming_mode()
t_env = TableEnvironment.create(env_settings)

t_env.create_temporary_table(
    'kafka_source',
    TableDescriptor.for_connector('kafka')
        .schema(Schema.new_builder()
                .column('cidade', DataTypes.STRING())
                .column('nome', DataTypes.STRING())
                .column('bairro', DataTypes.STRING())
                .column('id_compra', DataTypes.STRING())
                .build())
        .option('properties.bootstrap.servers', 'kafka:29092')
        .option('properties.group.id', 'group.usuarios')
        .option('format', 'json')
        .option('topic', 'usuarios')
        .option('scan.startup.mode', 'earliest-offset')
        .build())

# Criando tabela
table = t_env.from_path('kafka_source')

# Executando um select
result = table.select(col('cidade'), col('nome'), col('bairro'), col('id_compra'))

# Imprimindo o resultado
result.execute().print()
