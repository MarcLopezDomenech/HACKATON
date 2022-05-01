//Retorna si en la posició (x,y) hi ha un worker
fn can_move (x,y,work_ar,position){
  for w in 0..8 {
    let wx=worker(w).x;
    let wy=worker(w).y;
    if 40*x+y==40*wx+wy+position[w]{
      return false
    }
  }
  for w in work_ar{
    if w.x==x && w.y==y{
      return false
    }
  }
  return true
}

//Retorna si la casella (x,y) es troba dins del mapa i no esta pintada del nostre color.
fn should_move(map,x,y,our_color,work_ar,position){
  return 0<=x && x<=39 && 0<=y && y<=39 && map[x][y] != our_color && can_move(x,y,work_ar,position)
}

//donada una distancia d i un worker w, calcula el punt a distancia d que no sigui del nostre color,
//prioritzant si és d'un altre color. Retorna un enter entre 0 i 3 que significa:
//[0,1,2,3]=[up,down,right,left]
fn direction(map,z,d,work_a,position,init){
  if init==1{
    return direction1(map,z,d,work_a,position)
  } else if init==2{
    return direction2(map,z,d,work_a,position)
  } else if init==3{
    return direction3(map,z,d,work_a,position)
  } else if init==4{
    return direction4(map,z,d,work_a,position)
  }
}

//-------------------------------------

fn direction1(map,z,d,work_a,position){
  if d==40{
    info(`function fails`);
    return 1
  }
  let w=worker(z);
  let our_color=w.color;
  let result=4;
  let x=w.x;
  let y=w.y;
  for j in 0..2{
    for i in 0..d{
    //Primer quadrant
    if j==0 && should_move(map,x+d-i,y+i,our_color,work_a,position) {
      if map[x+d-i][y+i] == Tile::EMPTY {
        result=2;
      } else {
        //info(`it moves ${2}`);
        return 2
      }
    }
    //Quart quadrant
    if j==(z%2).abs() && should_move(map,x+d-i-1,y-i-1,our_color,work_a,position) {
      if map[x+d-i-1][y-i-1] == Tile::EMPTY {
        result=1;
      } else {
        //info(`it moves ${1}`);
        return 1
      }
    }
    //Segon quadrant
    if j!=(z%2).abs() && should_move(map,x-d+i+1,y+i+1,our_color,work_a,position) {
      if map[x-d+i+1][y+i+1] == Tile::EMPTY {
        result=0;
      } else {
        //info(`it moves ${0}`);
        return 0
      }
    }
    //Tercer quadrant
    if j==1 && should_move(map,x-d+i,y-i,our_color,work_a,position) {
      if map[x-d+i][y-i] == Tile::EMPTY {
        result=3;
      } else {
        //info(`it moves ${3}`);
        return 3
      }
    }
    }

  }
  if result<4{
    //info(`it moves ${result}`);
    return result
  }
  return direction1(map,z,d+1,work_a,position)
}

//---------------------------------------------

fn direction2(map,z,d,work_a,position){
  if d==40{
    info(`function fails`);
    return 1
  }
  let w=worker(z);
  let our_color=w.color;
  let result=4;
  let x=w.x;
  let y=w.y;
  for j in 0..2{
    for i in 0..d{
    //Segon quadrant
    if j==0 && should_move(map,x-d+i+1,y+i+1,our_color,work_a,position) {
      if map[x-d+i+1][y+i+1] == Tile::EMPTY {
        result=0;
      } else {
        //info(`it moves ${0}`);
        return 0
      }
    }
    //Primer quadrant
    if j==(z%2).abs() && should_move(map,x+d-i,y+i,our_color,work_a,position) {
      if map[x+d-i][y+i] == Tile::EMPTY {
        result=2;
      } else {
        //info(`it moves ${2}`);
        return 2
      }
    }
    //Tercer quadrant
    if j!=(z%2).abs() && should_move(map,x-d+i,y-i,our_color,work_a,position) {
      if map[x-d+i][y-i] == Tile::EMPTY {
        result=3;
      } else {
        //info(`it moves ${3}`);
        return 3
      }
    }
    //Quart quadrant
    if j==1 && should_move(map,x+d-i-1,y-i-1,our_color,work_a,position) {
      if map[x+d-i-1][y-i-1] == Tile::EMPTY {
        result=1;
      } else {
        //info(`it moves ${1}`);
        return 1
      }
    }
    }

  }
  if result<4{
    //info(`it moves ${result}`);
    return result
  }
  return direction2(map,z,d+1,work_a,position)
}

//----------------------------------------------------

fn direction3(map,z,d,work_a,position){
  if d==40{
    info(`function fails`);
    return 1
  }
  let w=worker(z);
  let our_color=w.color;
  let result=4;
  let x=w.x;
  let y=w.y;
  for j in 0..2{
    for i in 0..d{
    //Tercer quadrant
    if j==0 && should_move(map,x-d+i,y-i,our_color,work_a,position) {
      if map[x-d+i][y-i] == Tile::EMPTY {
        result=3;
      } else {
        //info(`it moves ${3}`);
        return 3
      }
    }
    //Segon quadrant
    if j==(z%2).abs() && should_move(map,x-d+i+1,y+i+1,our_color,work_a,position) {
      if map[x-d+i+1][y+i+1] == Tile::EMPTY {
        result=0;
      } else {
        //info(`it moves ${0}`);
        return 0
      }
    }
    //Quart quadrant
    if j!=(z%2).abs() && should_move(map,x+d-i-1,y-i-1,our_color,work_a,position) {
      if map[x+d-i-1][y-i-1] == Tile::EMPTY {
        result=1;
      } else {
        //info(`it moves ${1}`);
        return 1
      }
    }
    //Primer quadrant
    if j==1 && should_move(map,x+d-i,y+i,our_color,work_a,position) {
      if map[x+d-i][y+i] == Tile::EMPTY {
        result=2;
      } else {
        //info(`it moves ${2}`);
        return 2
      }
    }
    }

  }
  if result<4{
    //info(`it moves ${result}`);
    return result
  }
  return direction3(map,z,d+1,work_a,position)
}

//-------------------------------------------------------

fn direction4(map,z,d,work_a,position){
  if d==40{
    info(`function fails`);
    return 1
  }
  let w=worker(z);
  let our_color=w.color;
  let result=4;
  let x=w.x;
  let y=w.y;
  for j in 0..2{
    for i in 0..d{
    //Quart quadrant
    if j==0 && should_move(map,x+d-i-1,y-i-1,our_color,work_a,position) {
      if map[x+d-i-1][y-i-1] == Tile::EMPTY {
        result=1;
      } else {
        //info(`it moves ${1}`);
        return 1
      }
    }
    //Tercer quadrant
    if j==(z%2).abs() && should_move(map,x-d+i,y-i,our_color,work_a,position) {
      if map[x-d+i][y-i] == Tile::EMPTY {
        result=3;
      } else {
        //info(`it moves ${3}`);
        return 3
      }
    }
    //Primer quadrant
    if j!=(z%2).abs() && should_move(map,x+d-i,y+i,our_color,work_a,position) {
      if map[x+d-i][y+i] == Tile::EMPTY {
        result=2;
      } else {
        //info(`it moves ${2}`);
        return 2
      }
    }
    //Segon quadrant
    if j==1 && should_move(map,x-d+i+1,y+i+1,our_color,work_a,position) {
      if map[x-d+i+1][y+i+1] == Tile::EMPTY {
        result=0;
      } else {
        //info(`it moves ${0}`);
        return 0
      }
    }
    }

  }
  if result<4{
    //info(`it moves ${result}`);
    return result
  }
  return direction4(map,z,d+1,work_a,position)
}

//-------------------------------------------------------------------

if "init" in memory == false {
        let x=worker(0).x;
        let y=worker(0).y;
        if x<20 {
          if y<20{
            memory.init = 3; //x<20,y<20
          } else {
            memory.init = 2; //x<20,y>20
            }
        } else{
          if y<20{
            memory.init = 4; //x>20,y<20
          } else {
            memory.init = 1; //x>20,y>20
            }
        }
} else {
        memory.init+=0;
}

let position=[];
position.pad(8,0);
fn main(w) {
  let init=memory.init;
  let work_ar=map.workers;
  let dir=direction(map,w,1,work_ar,position,init);
    if dir==0 {
      info(`worker ${w} moves to [${worker(w).x},${worker(w).y+1}]`);
      position[w]=1;
      worker(w).move_up();
    }
    else if dir==1 {
      info(`worker ${w} moves to [${worker(w).x},${worker(w).y-1}]`);
      position[w]=-1;
      worker(w).move_down();
    }
    else if dir==2 {
      info(`worker ${w} moves to [${worker(w).x+1},${worker(w).y}]`);
      position[w]=40;
      worker(w).move_right();
    }
    else if dir==3 {
      info(`worker ${w} moves to [${worker(w).x-1},${worker(w).y}]`);
      position[w]=-40;
      worker(w).move_left();
    } else {
    info(`${w} fails `);
    }
}

//-------------------------------------------------------------------

if "tick" in memory == false {
        memory.tick = 0;
} else {
        memory.tick += 1;
}

if memory.tick < 30{
for w in 1..6{
main(w);
}
for w in 6..8{
  if memory.init == 1{
    worker(w).move_down();
  }
  if memory.init == 2{
    worker(w).move_right();
  }
  if memory.init == 3{
    worker(w).move_up();
  }
  if memory.init == 4{
    worker(w).move_left();
  }
}
} else if memory.tick < 60{
for w in 1..4{
main(w);
}
for w in 6..8{
main(w);
}
for w in 4..6{
  if memory.init == 1{
    worker(w).move_down();
  }
  if memory.init == 2{
    worker(w).move_right();
  }
  if memory.init == 3{
    worker(w).move_up();
  }
  if memory.init == 4{
    worker(w).move_left();
  }
}
} else if memory.tick == 60{
let mean_x=0.0;
for w in map.workers{
  mean_x+=w.x;
}
mean_x/=32;
let mean_y=0.0;
for w in map.workers{
  mean_y+=w.y;
}
mean_y/=32;
}

//-----------------------------------------------------------------

if memory.tick >=60 & memory.tick <= 100{

}
