"""Funció que retorna un vector amb la puntuació de cada color:
Puntuació=[verd, groc, vermell, blau]"""
fn puntuacio(){
    let Puntuacio=[0,0,0,0];
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
