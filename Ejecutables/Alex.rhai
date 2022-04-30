//Retorna si en la posició (x,y) hi ha un worker
fn can_move(x,y,work_arr){
  for w in work_arr{
    if w.x==x && w.y==y{
      false;
    }
  }
  true
}

//Retorna si la casella (x,y) es troba dins del mapa i no esta pintada del nostre color.
fn should_move(map,x,y,our_color,work_a){
  -1<x<40 && -1<y<4'0 && map[x][y] != our_color && can_move(x,y,work_a)
}

//donada una distancia d i un worker w, calcula el punt a distancia d que no sigui del nostre color,
//prioritzant si és d'un altre color. Retorna un enter entre 0 i 3 que significa:
//[0,1,2,3]=[up,down,right,left]
fn direction(map,w,d,work_a){
  if d==10{
    1
  }
  let our_color=w.color;
  let result=4;
  let x=w.x;
  let y=w.y;
  for i in 0..d{
    //Primer quadrant
    if should_move(map,x+d-i,y+i,our_color,work_a) {
      if map[x+d-i][y+i] == Tile::EMPTY {
        result=2;
      } else {
        2
      }
    }
    //Quart quadrant
    if should_move(map,x+d-i,y-i,our_color,work_a) {
      if map[x+d-i][y-i] == Tile::EMPTY {
        result=2;
      } else {
        2
      }
    }
    //Segon quadrant
    if should_move(map,x-d+i,y+i,our_color,work_a) {
      if map[x-d+i][y+i] == Tile::EMPTY {
        result=2;
      } else {
        2
      }
    }
    //Tercer quadrant
    if should_move(map,x-d+i,y-i,our_color,work_a) && map[x-d+i][y-i] != Tile::EMPTY {
      if map[x+d-i][y-i] == Tile::EMPTY {
        result=2;
      } else {
        2
      }
    }
  }
  if result<4{
    result
  }
  if should_move(map,x,y+d,our_color,work_a) {
    0
  }
  if should_move(map,x,y+d,our_color,work_a) {
    1
  }
  direction(map,w,d+1,work_a)
}

  for w in 0..8 {
    let work_ar=map.workers;
    let dir=direction(map,worker(w),1,work_ar);
      if dir==0 {
        worker(w).move_up();
      }
      else if dir==1 {
        worker(w).move_down();
      }
      else if dir==2 {
        worker(w).move_right();
      }
      else if dir==3 {
        worker(w).move_left();
      }
      info(`worker ${w} finished`);
    }
