fn puntuacio(){
    let Puntuacio=[0,0,0,0];
    for x in 0..40 {
        for y in 0..40 {
            if map[x][y] == Tile::GREEN {
                Puntacio[0]+=1;
              }
            if map[x][y] == Tile::YELLOW {
                Puntacio[1]+=1;
              }
            if map[x][y] == Tile::RED {
                Puntacio[2]+=1;
              }
            if map[x][y] == Tile::BLUE {
                Puntacio[3]+=1;
              }
            }
        }
    Puntacio
}

fn max(a,b,c,d){
  if a>b & a>c & a>d {
    0
  } else if b>c & b>d {
    1
  } else if c>d {
    2
  } else {
    3
  }
}

for w in 0..8 {
    let P=puntuacio();
    let r = max(P[0],P[1],P[2],P[3]);
    switch r {
        0 => worker(w).move_up(),
        1 => worker(w).move_down(),
        2 => worker(w).move_right(),
        3 => worker(w).move_left(),
    }
    info(`worker ${w} finished`);
  }
