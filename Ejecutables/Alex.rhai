//Da si(x,y) es una posición valida
fn valid_pos(x,y){
  if x<40 && x>=0 & y>=0 && y<40{
    return true
  }
  return false
}
//Retorna si en la posició (x,y) hi ha un worker
fn can_move(x,y,work_ar){
  for w in work_ar{
    if w.x==x && w.y==y{
      return false
    }
  }
  return true
}

//Modifica la posició del worker a la posició (x,y) en la posició (x1,y1)
//work_a=map.workers
fn move(x,y,work_a,x1,y1){
  if(valid_pos(x1,y1)){
    for w1 in work_a{
      if w1.x==x && w1.y==y{
        w1.x=x1;
        w1.y=y1;
        break
      }
    }
  }
  else{
    info(`error movimiento`);
  }
}

//Retorna si la casella (x,y) es troba dins del mapa i no esta pintada del nostre color.
fn should_move(map,x,y,our_color,work_ar){
  return valid_pos(x,y) && map[x][y] != our_color && can_move(x,y,work_ar)
}

//donada una distancia d i un worker w, calcula el punt a distancia d que no sigui del nostre color,
//prioritzant si és d'un altre color. Retorna un enter entre 0 i 3 que significa:
//[0,1,2,3]=[up,down,right,left]
fn direction(map,w,d,work_a){
  if d==10{
    info(`function fails`);
    return 1
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
        info(`it moves ${2}`);
        return 2
      }
    }
    //Quart quadrant
    if should_move(map,x+d-i,y-i,our_color,work_a) {
      if map[x+d-i][y-i] == Tile::EMPTY {
        result=2;
      } else {
        info(`it moves ${2}`);
        return 2
      }
    }
    //Segon quadrant
    if should_move(map,x-d+i,y+i,our_color,work_a) {
      if map[x-d+i][y+i] == Tile::EMPTY {
        result=3;
      } else {
        info(`it moves ${3}`);
        return 3
      }
    }
    //Tercer quadrant
    if should_move(map,x-d+i,y-i,our_color,work_a) && map[x-d+i][y-i] != Tile::EMPTY {
      if map[x+d-i][y-i] == Tile::EMPTY {
        result=3;
      } else {
        info(`it moves ${3}`);
        return 3
      }
    }
  }
  if result<4{
    info(`it moves ${result}`);
    return result
  }
  if should_move(map,x,y+d,our_color,work_a) {
    info(`it moves ${0}`);
    return 0
  }
  if should_move(map,x,y-d,our_color,work_a) {
    info(`it moves ${1}`);
    return 1
  }
  direction(map,w,d+1,work_a)
}

let work_ar=map.workers;
for w in 0..8 {
  let dir=direction(map,worker(w),1,work_ar);
  let x=worker(w).x;
  let y=worker(w).y;
    if dir==0 {
      move(x,y,work_ar,x,y+1);
      worker(w).move_up();
    }
    else if dir==1 {
      move(x,y,work_ar,x,y-1);
      worker(w).move_down();
    }
    else if dir==2 {
      move(x,y,work_ar,x+1,y);
      worker(w).move_right();
    }
    else if dir==3 {
      move(x,y,work_ar,x-1,y);
      worker(w).move_left();
    } else {
    info(`${w} fails `);
    }
    //info(`worker ${w} finished`);
  }
