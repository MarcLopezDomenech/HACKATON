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
//Retorna si la casella (x,y) es troba dins del mapa i no esta pintada del nostre color.
fn con_move(map,x,y,our_color,work_ar,M,C,i,j){
  if(valid_pos(x,y)){
    return C[x][y] != C[i][j] && M[i][j] == 0 &&can_move(x,y,work_ar,M)
  }
  return false
}

//donada una distancia d i un worker w, calcula el punt a distancia d que no sigui del nostre color,
//prioritzant si és d'un altre color. Retorna un enter entre 0 i 3 que significa:
//[0,1,2,3]=[up,down,right,left]
fn direction(map,w,d,work_a,M,resultat_c,dist_c,x_c,y_c){
  if d>40{
    info(`function fails`);
    return 1
  }
  let our_color=w.color;
  let Result=[4,0,0];
  let Resultat_p=[4,0,0];
  let x=w.x;
  let y=w.y;
  let dist;
  for i in 0..d{
    //Primer quadrant
    dist=d;
    if should_move(map,x+d-i,y+i,our_color,work_a,M) {
      if map[x+d-i][y+i] == Tile::EMPTY {
        Result=[2,x+d-i,y+i]; 
      }else{
        //info(`it moves ${2}`);
        Resultat_p=[2,x+d-i,y+i];
      }
    }
    //Quart quadrant
    if should_move(map,x+d-i,y-i,our_color,work_a,M) {
      if map[x+d-i][y-i] == Tile::EMPTY {
        Result=[2,x+d-i,y-i];
      } else {
        //info(`it moves ${2}`);
        Resultat_p=[2,x+d-i,y-i];
      }
    }
    //Segon quadrant
    if should_move(map,x-d+i,y+i,our_color,work_a,M) {
      if map[x-d+i][y+i] == Tile::EMPTY {
        Result=[3,x-d+i,y+i];
      } else {
        //info(`it moves ${3}`);
        Resultat_p=[3,x-d+i,y+i];
      }
    }
    //Tercer quadrant
    if should_move(map,x-d+i,y-i,our_color,work_a,M){
      if map[x-d+i][y-i] == Tile::EMPTY {
        Result=[3,x-d+i,y-i];
      } else {
        //info(`it moves ${3}`);
        Resultat_p=[3,x-d+i,y-i];
      }
    }
  }
  if should_move(map,x,y+d,our_color,work_a,M) {
    if map[x][y+d] == Tile::EMPTY {
      Result=[0,x,y+d];
    } else {
      //info(`it moves ${0}`);
      Resultat_p=[0,x,y+d];
    }
  }
  if should_move(map,x,y-d,our_color,work_a,M) {
    //info(`it moves ${1}`);
    if map[x][y-d] == Tile::EMPTY {
      Result=[1,x,y-d];
    } 
    else{
      Resultat_p=[1,x,y-d];;
    }
  }
  if Resultat_p[0]<4 && dist+4<dist_c{
    //info(`it moves ${result}`);
    return Resultat_p
  }
  if Result[0]<4 && dist+5<dist_c{
    //info(`it moves ${result}`);
    return Result
  }
  if dist > dist_c{
    return [resultat_c,x_c,y_c]
  }
  direction(map,w,d+1,work_a,M,resultat_c,dist_c,x_c,y_c)
}
fn direc_c(map,w,d,work_a,M,C){
  if d>40{
    info(`function fails`);
    return 1
  }
  let our_color=w.color;
  let x=w.x;
  let y=w.y;
  for i in 0..d{
    //Primer quadrant
    if con_move(map,x+d-i,y+i,our_color,work_a,M,C,x,y) {
      return [2,d,x+d-i,y+i]
    }
    //Quart quadrant
    if con_move(map,x+d-i,y-i,our_color,work_a,M,C,x,y) {
      return [2,d,x+d-i,y-i]
    }
    //Segon quadrant
    if con_move(map,x-d+i,y+i,our_color,work_a,M,C,x,y) {
      return [3,d,x-d+i,y+i]
    }
    //Tercer quadrant
    if con_move(map,x-d+i,y-i,our_color,work_a,M,C,x,y){
      return [3,d,x-d+i,y-i]
    }
  }
  if con_move(map,x,y+d,our_color,work_a,M,C,x,y) {
    return [0,d,x,y+d]
  }
  if con_move(map,x,y-d,our_color,work_a,M,C,x,y) {
    //info(`it moves ${1}`);
    return [1,d,x,y-d]
  }
  direc_c(map,w,d+1,work_a,M,C)
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
  let C=direc_c(map,worker(w),1,work_ar,M,C);
  let resultat_c=C[0];
  let dist_c=C[1];
  let x_c=C[2];
  let y_c=C[3];
  let RES=direction(map,worker(w),1,work_ar,M,resultat_c,dist_c,x_c,y_c);
  let dir=RES[0];
  let x_n=RES[1];
  let y_n=RES[2];
  M[worker(w).x][worker(w).y]=0;
  M[x_n][y_n]=1;
    if dir==0 {
      info(`worker ${w} moves to [${worker(w).x},${worker(w).y+1}]`);
      worker(w).move_up();
    }
    else if dir==1 {
      info(`worker ${w} moves to [${worker(w).x},${worker(w).y-1}]`);
      worker(w).move_down();
    }
    else if dir==2 {
      info(`worker ${w} moves to [${worker(w).x+1},${worker(w).y}]`);
      worker(w).move_right();
    }
    else if dir==3 {
      info(`worker ${w} moves to [${worker(w).x-1},${worker(w).y}]`);
      worker(w).move_left();
    } else {
    info(`${w} fails `);
    }
  }
