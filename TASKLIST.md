# Cosas a hacer
## Pendiente
- [ ] Contador de los puntos que tenemos y de los enemigos
- [ ] Que casillas nos dan el máximo aumento de puntos(Valor de cada casilla)
- [ ] Que casillas resta el máximo número de puntos(Valor de cada casilla)

## Features
- [ ] Comunicación de los movimientos entre unidades
- [ ] Grafo de todas las posiciones con pesos
## Estrategias
## Probelmas
- [ ] Cuantos puntos de media serían necesarios para ganar
- [ ] Como es la mejor manera de interconectar conjuntos
- [ ] En que posición queremos que esten nuestras fichas de "normal"


"""Funció que retorna un vector amb la puntuació de cada color:
Puntuació=[verd, groc, vermell, blau]"""
fn puntuacio(){
    let Puntuacio=[0,0,0,0]
    for x in 0..40 {
        for y in 0..40 {
            if map[x][y] == Tile::GREEN {
                Puntacio[0]+=1
              }
            if map[x][y] == Tile::YELLOW {
                Puntacio[1]+=1
              }
            if map[x][y] == Tile::RED {
                Puntacio[2]+=1
              }
            if map[x][y] == Tile::BLUE {
                Puntacio[3]+=1
              }
            }
        }
    Puntacio
}
