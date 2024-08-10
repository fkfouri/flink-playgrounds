from confluent_kafka import Producer
from faker import Faker
import json
import uuid
import time
from os import getenv

def delivery_callback(err, msg):
    if err:
        print(f"🔴 Message delivery failed: {err}")
    else:
        _msg = (
            f"🟢 Produced event to topic {msg.topic()} [{msg.partition()}] as offset {msg.offset()} \n"
            f"Total Size: {len(msg.value()) / 1024:.3f} Kbytes"
        )
        print(_msg)


if __name__ == "__main__":
    conf = {
        'bootstrap.servers': getenv('BOOTSTRAP_SERVER', 'localhost:9092'),
        # 'client.id': 'produtor_compras'
    }
    topic = "compras"

    # criar um producer
    producer = Producer(**conf)

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
            })

            key = str(uuid.uuid4()) 
            producer.produce('compras', key=key, value=compra, callback=None)    
            count+=1

        except Exception as e:
            print(f"Erro ao enviar mensagem: {e}")
        

        time.sleep(0)
        producer.poll(0)
        producer.flush()

        if count>300: break

