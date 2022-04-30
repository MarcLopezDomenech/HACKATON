//Funció que retorna un vector amb la puntuació de cada color:
//Puntuació=[verd, groc, vermell, blau]
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

<<<<<<< Updated upstream
//Retorna si en la posició (x,y) hi ha un worker
fn can_move(x,y){
  for w in map.workers{
    if w.x==x & w.y==y{
      false
    }
  }
  true
=======
"Dada posición x, y del mapa dice que worker tuyo llega antes"
fn llega_antes(x, y){
  let min_d = 81;
  let min_player = 0;
  for i in 0..8{
    let xw=worker(i).x;
    let yw=worker(i).y;
    dist = (xw-x).abs + (yw-y).abs();
    if dist<min_d{
      min_d=dist;
      min_player=i;
    }
  }
  i
>>>>>>> Stashed changes
}
