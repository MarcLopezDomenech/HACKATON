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

fn new_mat(x, y) {
  let row = [];
  row.pad(y, 0);

  let matrix = [];
  matrix.pad(x, row);

  matrix
}
let C=new_mat(40,40);
/*
fn puntuacio(map){
  let Puntuacio=[0,0,0,0];
  for x in 0..40 {
      for y in 0..40 {
          if map[x][y] == Tile::GREEN {
              Puntuacio[0]+=1
            }
          if map[x][y] == Tile::YELLOW {
              Puntuacio[1]+=1
            }
          if map[x][y] == Tile::RED {
              Puntuacio[2]+=1
            }
          if map[x][y] == Tile::BLUE {
              Puntuacio[3]+=1
            }
          }
      }
  return Puntuacio
}
*/
fn con_rec(C,map,color,i,j){
  let stac=[];
  stac.push(i);
  stac.push(j);
  let a=0;
  let y=0;
  let u=C[i][j];
  while(stac.len!=0){
    y=stac.pop();
    a=stac.pop();
    info(`${a}, ${y}`);

    if(valid_pos(-1+a,y) && map[-1+a][y]==color && C[-1+a][y]==0){
      C[a-1][y]=u;
      stac.push(-1+a);
      stac.push(y);
    }
    if(valid_pos(a+1,y) && map[a+1][y]==color && C[a+1][y]==0){
      C[a+1][y]=u;
      stac.push(a+1);
      stac.push(y);
    }
    if(valid_pos(a,y-1) && map[a][y-1]==color && C[a][y-1]==0){
      C[a][y-1]=u;
      stac.push(a);
      stac.push(y-1);
    }
    if(valid_pos(a,y+1) && map[a][y+1]==color && C[a][y+1]==0){
      C[a][y+1]=u;
      stac.push(a);
      stac.push(y+1);
    }
  }
  return C;
}
//Retorna la matriu components conexes
fn conexes(C,map,color){
  let cont = 0;
  //let num=punt;
  for j in 0..40{
    for i in 0..40{
      if(map[i][j]==color && C[i][j]==0){
        info(`Entrada ${i}, ${j}`);
          cont=cont+1;
          C[i][j]=cont;
          C=con_rec(C,map,color,i,j);
      }
    }
  }
  return [cont,C];
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
//let P=puntuacio(map);
//let m_punt;
let color=map.my_color;
/*
if(color==Tile::GREEN){
  m_punt=P[0];
}
else if(color==Tile::YELLOW){
  m_punt=P[1];
}
else if(color==Tile::RED){
  m_punt=P[2];
}
else if(Tile::BLUE){
  m_punt=P[3];
*/

let R=conexes(C,map,color);
let num_con=R[0];
C=R[1];
info(`Num. de comp conexas ${num_con} `);
for w in 0..8 {
// color=worker(w).our_color;
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
