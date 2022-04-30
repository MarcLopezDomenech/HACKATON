fn new_mat(x, y) {
  let row = [];
  row.pad(y, 0);

  let matrix = [];
  matrix.pad(x, row);

  matrix
}
//Retorna si en la posició (x,y) hi ha un worker
fn can_move(x,y,work_ar,M){
  for w in work_ar{
    if w.x==x && w.y==y{
      return false
    }
  }
  if(M[x][y]==1){
    return false
  }
  return true
}

//Da si(x,y) es una posición valida
fn valid_pos(x,y){
  if(x<=39 && x>=0 && y>=0 && y<=39){
    return true
  }
  return false
}

//Retorna si la casella (x,y) es troba dins del mapa i no esta pintada del nostre color.
fn should_move(map,x,y,our_color,work_ar,M){
  if(valid_pos(x,y)){
    return map[x][y] != our_color && can_move(x,y,work_ar,M)
  }
  return false
}

//donada una distancia d i un worker w, calcula el punt a distancia d que no sigui del nostre color,
//prioritzant si és d'un altre color. Retorna un enter entre 0 i 3 que significa:
//[0,1,2,3]=[up,down,right,left]
fn direction(map,w,d,work_a,M){
  if d>40{
    info(`function fails`);
    return 1
  }
  let our_color=w.color;
  let result=4;
  let x=w.x;
  let y=w.y;
  for i in 0..d{
    //Primer quadrant
    if should_move(map,x+d-i,y+i,our_color,work_a,M) {
      if map[x+d-i][y+i] == Tile::EMPTY {
        result=2;
      } else {
        //info(`it moves ${2}`);
        return 2
      }
    }
    //Quart quadrant
    if should_move(map,x+d-i,y-i,our_color,work_a,M) {
      if map[x+d-i][y-i] == Tile::EMPTY {
        result=2;
      } else {
        //info(`it moves ${2}`);
        return 2
      }
    }
    //Segon quadrant
    if should_move(map,x-d+i,y+i,our_color,work_a,M) {
      if map[x-d+i][y+i] == Tile::EMPTY {
        result=3;
      } else {
        //info(`it moves ${3}`);
        return 3
      }
    }
    //Tercer quadrant
    if should_move(map,x-d+i,y-i,our_color,work_a,M){
      if map[x-d+i][y-i] == Tile::EMPTY {
        result=3;
      } else {
        //info(`it moves ${3}`);
        return 3
      }
    }
  }
  if should_move(map,x,y+d,our_color,work_a,M) {
    if map[x][y+d] == Tile::EMPTY {
      result=0;
    } else {
      //info(`it moves ${0}`);
      return 0
    }
  }
  if should_move(map,x,y-d,our_color,work_a,M) {
    //info(`it moves ${1}`);
    return 1
  }
  if result<4{
    //info(`it moves ${result}`);
    return result
  }
  direction(map,w,d+1,work_a,M)
}

let M=new_mat(40,40);
for w in 0..8 {
  let work_ar=map.workers;
  let dir=direction(map,worker(w),1,work_ar,M);
    if dir==0 {
      info(`worker ${w} moves to [${worker(w).x},${worker(w).y+1}]`);
      M[worker(w).x][worker(w).y+1]=1;
      worker(w).move_up();
    }
    else if dir==1 {
      info(`worker ${w} moves to [${worker(w).x},${worker(w).y-1}]`);
      M[worker(w).x][worker(w).y-1]=1;
      worker(w).move_down();
    }
    else if dir==2 {
      info(`worker ${w} moves to [${worker(w).x+1},${worker(w).y}]`);
      M[worker(w).x+1][worker(w).y]=1;
      worker(w).move_right();
    }
    else if dir==3 {
      info(`worker ${w} moves to [${worker(w).x-1},${worker(w).y}]`);
      M[worker(w).x-1][worker(w).y]=1;
      worker(w).move_left();
    } else {
    info(`${w} fails `);
    }
  }
