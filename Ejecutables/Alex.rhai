fn puntuacio(map){
    let punt=[0,0,0,0];
    for x in 0..40 {
        for y in 0..40 {
            if map[x][y] == Tile::GREEN {
                punt[0]+=1;
            }
            else if map[x][y] == Tile::YELLOW {
                punt[1]+=1;
            }
            else if map[x][y] == Tile::RED {
                punt[2]+=1;
            }
            else if map[x][y] == Tile::BLUE {
                punt[3]+=1;
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
    let P=puntuacio(map);
    let r = max(P[0],P[1],P[2],P[3]);
    switch r {
        0 => worker(w).move_up(),
        1 => worker(w).move_down(),
        2 => worker(w).move_right(),
        3 => worker(w).move_left(),
    }
    info(`worker ${w} finished`);
  }
