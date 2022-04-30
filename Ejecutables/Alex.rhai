//Retorna si en la posició (x,y) hi ha un worker
fn can_move(x,y,work_arr){
  for w in work_arr{
    if work_arr.x==x && work_arr.y==y{
      false
    }
  }
  true
}

//donada una distancia d i un worker w, calcula el punt a distancia d que no sigui del nostre color,
//prioritzant si és d'un altre color. Retorna un enter entre 0 i 3 que significa:
//[0,1,2,3]=[up,down,right,left]
fn direction(map,w,d,work_a){
  let not_found_yet=true;
  let our_color=w.color;
  let x=w.x;
  let y=w.y;
  for i in 0..d{
    //Primer quadrant
    if not_found_yet && x+d-i<40 && y+i<40 && map[x+d-i][y+i] != our_color && map[x+d-i][y+i] != Tile::EMPTY && can_move(x+d-i,y+i,work_a){
      not_found_yet=false;
      2
    }
    //Quart quadrant
    if not_found_yet && x+d-i<39 && y-i>-1 && map[x+d-i][y-i] != our_color && map[x+d-i][y-i] != Tile::EMPTY && can_move(x+d-i,y-i,work_a){
      not_found_yet=false;
      2
    }
    //Segon quadrant
    if not_found_yet && x-d+i>-1 && y+i<40 && map[x-d+i][y+i] != our_color && map[x-d+i][y+i] != Tile::EMPTY && can_move(x+d-i,y+i,work_a){
      not_found_yet=false;
      3
    }
    //Tercer quadrant
    if not_found_yet && x-d+i>-1 && y-i>-1 && map[x-d+i][y-i] != our_color && map[x-d+i][y-i] != Tile::EMPTY && can_move(x-d+i,y-i,work_a){
      not_found_yet=false;
      3
    }
  }
  for i in 0..d{
    //Primer quadrant
    if not_found_yet && x+d-i<40 && y+i<40 && map[x+d-i][y+i] != our_color && can_move(x+d-i,y+i,work_a) {
      not_found_yet=false;
      2
    }
    //Quart quadrant
    if not_found_yet && x+d-i<39 && y-i>-1 && map[x+d-i][y-i] != our_color && can_move(x+d-i,y-i,work_a) {
      not_found_yet=false;
      2
    }
    //Segon quadrant
    if not_found_yet && x-d+i>-1 && y+i<40 && map[x-d+i][y+i] != our_color && can_move(x-d+i,y+i,work_a) {
      not_found_yet=false;
      3
    }
    //Tercer quadrant
    if not_found_yet && x-d+i>-1 && y-i>-1 && map[x-d+i][y-i] != our_color && can_move(x-d+i,y-i,work_a) {
      not_found_yet=false;
      3
    }
  }
  if not_found_yet && y+d<40 && map[x][y+d] != our_color && map[x][y+d] != Tile::EMPTY && can_move(x,y+d,work_a){
    not_found_yet=false;
    0
  }
  if not_found_yet && y-d>-1 && map[x][y-d] != our_color && map[x][y-d] != Tile::EMPTY && can_move(x,y-d,work_a){
    not_found_yet=false;
    1
  }
  if not_found_yet{
    direction(map,w,d+1)
  }
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
