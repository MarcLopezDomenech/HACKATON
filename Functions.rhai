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

//Retorna si en la posició (x,y) es enemiga
fn casilla_enemiga(x,y,map){
  if map[x][y]!=Tile::EMPTY && map[x][y]!=map.mycolor(){
      return true;
  }
  return false;
}

//Retorna si en la posició (x,y) es buida
fn casilla_buida(x,y){
  if map[x][y]==Tile::EMPTY{
      return true;
  }
  return false;
}

//Retorna si en la posició (x,y) hi ha un worker
fn can_move(x,y,work_ar){
  for w in work_ar{
    if w.x==x && w.y==y{
      false
    }
  }
  true
}

//Modifica la posició del worker a la posició (x,y) en la posició (x1,y1)
//work_a=map.workers
fn move(x,y,work_a,x1,y1){
  for w in map.work_a{
    if w.x==x && w.y==y{
      w.x=x1;
      w.y=x2;
      break
    }
  }
}

//Da si(x,y) es una posición valida
fn valid_pos(x,y){
  if x<40 && x>=0 & y>=0 && y<40{
    true
  }
  false
}


/* Desactualizado
//Retorna si en la posició (x,y) hi ha un worker
fn can_move(x,y){
  for w in map.workers{
    if w.x==x & w.y==y{
      false
    }
  }
  true
}
fn distancia(w1,w2){
    dx = (worker(w1).x - worker(w2).x).abs();
    dy = (worker(w1).y - worker(w2).y).abs();
    return dx+dy;
}
*/
