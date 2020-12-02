import redis

REDIS_PORT = 6379
REDIS_HOST = 'localhost'

r = redis.Redis(host=REDIS_HOST, port=REDIS_PORT, db=0)

print(r.ping())

r.set('Texto', 'Hola')
print(r.get('Texto'))

r.lpush("palabra","hola")
r.lpush("palabra","hola")
print(r.lrange("palabra",0,-1))

r.sadd('idioma', 'español')
r.sadd('idioma', 'ingles')
r.sadd('idioma', 'aleman')
print(r.smembers('idioma'))
