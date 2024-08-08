from confluent_kafka import Producer
from faker import Faker
import json
import uuid
import time
from os import getenv

if __name__ == "main":
    conf = {
        'bootstrap.servers': getenv('BOOTSTRAP_SERVER', 'localhost:9092'),
        'client.id': 'produtor_compras'
    }

    # criar um producer
    p = Producer(**conf)


    # criar um objeto Faker
    faker = Faker({'pt_BR'})
    data_format = "%Y-%m-%d"

    count=0
    while True:
        try:
            produto = faker.word()
            preco = str(faker.random_digit()) + "." + str(faker.random_number(digits=2))
            data = faker.date_between(start_date='-3y', end_date='today').strftime(data_format)
            valor = faker.random_number(digits=4)

            print(f"Enviando -> {produto} - {preco} - {data} - {valor}")
            compra = json.dumps({
                "id_compra": count,
                "produto": produto,
                "preco": preco,
                "data": data,
                "valor": valor
            }).encode('utf-8')

            key = str(uuid.uuid4()) 
            p.produce('compras', value=compra, key=key)    

            count+=1

        except Exception as e:
            print(f"Erro ao enviar mensagem: {e}")
        

        time.sleep(0)
        p.poll(0)
        p.flush()


