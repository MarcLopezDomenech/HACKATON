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
    return C[x][y] != C[i][j] && can_move(x,y,work_ar,M)
  }
  return false
}

//donada una distancia d i un worker w, calcula el punt a distancia d que no sigui del nostre color,
//prioritzant si és d'un altre color. Retorna un enter entre 0 i 3 que significa:
//[0,1,2,3]=[up,down,right,left]
fn direction(map,w,d,work_a,M,resultat_c,dist_c){

  if d>40{
    info(`function fails`);
    return 1
  }
  r=[0,0,0]
  let our_color=w.color;
  let result=4;
  let resultat_p=4;
  let x=w.x;
  let y=w.y;
  let dist;
  for i in 0..d{
    //Primer quadrant
    dist=d;
    if should_move(map,x+d-i,y+i,our_color,work_a,M) {
      if map[x+d-i][y+i] == Tile::EMPTY {
        result=2;
      }else{
        //info(`it moves ${2}`);
        resultat_p=2;
      }
    }
    //Quart quadrant
    if should_move(map,x+d-i,y-i,our_color,work_a,M) {
      if map[x+d-i][y-i] == Tile::EMPTY {
        result=2;
        r[1]=x+d-i
        r[2]=y-i
      } else {
        //info(`it moves ${2}`);
        resultat_p=2;
      }
    }
    //Segon quadrant
    if should_move(map,x-d+i,y+i,our_color,work_a,M) {
      if map[x-d+i][y+i] == Tile::EMPTY {
      r[1]=x-d+i
      r[2]=y+i
        result=3;
      } else {
        //info(`it moves ${3}`);
        resultat_p=3;
      }
    }
    //Tercer quadrant
    if should_move(map,x-d+i,y-i,our_color,work_a,M){
      if map[x-d+i][y-i] == Tile::EMPTY {
      r[1]=x-d+i
      r[2]=y-i
        result=3;
      } else {
        //info(`it moves ${3}`);
        resultat_p=3;
      }
    }
  }
  if should_move(map,x,y+d,our_color,work_a,M) {
    if map[x][y+d] == Tile::EMPTY {
    r[1]=x
    r[2]=y+d
      result=0;
    } else {
      //info(`it moves ${0}`);
      resultat_p=0;
    }
  }
  if should_move(map,x,y-d,our_color,work_a,M) {
    //info(`it moves ${1}`);
    if map[x][y-d] == Tile::EMPTY {
    r[1]=x
    r[2]=y-d
      result=1;
    }
    else{
      resultat_p=1;
    }
  }
  if resultat_p<4 && dist+4<dist_c{
    //info(`it moves ${result}`);
    result= resultat_p
  }
  //if result<4 && dist+5<dist_c{
    //info(`it moves ${result}`);
    //return result}
  if dist > dist_c{
    result= resultat_c
  }
  r[0]=result
  direction(map,w,d+1,work_a,M,resultat_c,dist_c)
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
      return [2,d]
    }
    //Quart quadrant
    if con_move(map,x+d-i,y-i,our_color,work_a,M,C,x,y) {
      return [2,d]
    }
    //Segon quadrant
    if con_move(map,x-d+i,y+i,our_color,work_a,M,C,x,y) {
      return [3,d]
    }
    //Tercer quadrant
    if con_move(map,x-d+i,y-i,our_color,work_a,M,C,x,y){
      return [3,d]
    }
  }
  if con_move(map,x,y+d,our_color,work_a,M,C,x,y) {
    return [0,d]
  }
  if con_move(map,x,y-d,our_color,work_a,M,C,x,y) {
    //info(`it moves ${1}`);
    return [1,d]
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
  let dir=direction(map,worker(w),1,work_ar,M,resultat_c,dist_c);

  fn anticipa (n, map.workers, M, map){
  Obj=new_mat(8,2)
  for w=0..8{
  Obj[w][0]=direction_OBJ(map,w,1,map.workers,M)[1];
  Obj[w][1]=direction_OBJ(map,w,1,map.workers,M)[2];
  }
  return Obj
  }

  //dada pareja i, j dice si solapan trabajo (dist(obji, objj)<eps), si solapan + cerca
  //0, no solapan
  //1 solapan y el más cercano es j
  //-1 solapan y el más cercano es i
  fn sobran(i, j, eps, map.workers, Obj){
  d=(Obj[i][0]-Obj[j][0])*(Obj[i][0]-Obj[j][0])+(Obj[i][1]-Obj[j][1])*(Obj[i][1]-Obj[j][1]))
  solapan= d2<eps*eps;
  ij=abs(Obj[i][0]-map.workers(i).x)+abs(Obj[i][1]-map.workers(i).y)-(abs(Obj[j][0]-map.workers(j).x)+abs(Obj[j][1]-map.workers(j).y))
  if (ij>0){
  ij=1
  }
  else{
  ij=-1
  }
  return ij*solapan;
  }

RESULTS=new_mat(8,3);
for w=0..{
RESULTS[w]=direction(map,w,d,work_a,M,resultat_c,dist_c);}

max=2
for i=0..8{
  for j=i+1..8{
  a=solapan(i,j, 2
  if(solapan(i,j, 2)==0 || max<=0){}
      if RESULTS[i][0]==0 {
        info(`worker ${i} moves to [${worker(i).x},${worker(i).y+1}]`);
        M[worker(i).x][worker(i).y+1]=1;
        worker(i).move_up();
      }
      else if RESULTS[i][0]==1 {
        info(`worker ${i} moves to [${worker(i).x},${worker(i).y-1}]`);
        M[worker(w).x][worker(w).y-1]=1;
        worker(w).move_down();
      }
      else if RESULTS[i][0]==2 {
        info(`worker ${i} moves to [${worker(i).x+1},${worker(i).y}]`);
        M[worker(i).x+1][worker(i).y]=1;
        worker(i).move_right();
      }
      else if RESULTS[i][0]==3 {
        info(`worker ${i} moves to [${worker(i).x-1},${worker(i).y}]`);
        M[worker(i).x-1][worker(i).y]=1;
        worker(i).move_left();

        else if RESULTS[j][0]==1 {
          info(`worker ${j} moves to [${worker(j).x},${worker(j).y-1}]`);
          M[worker(j).x][worker(j).y-1]=1;
          worker(j).move_down();
        }
        else if RESULTS[j][0]==2 {
          info(`worker ${j} moves to [${worker(j).x+1},${worker(w).y}]`);
          M[worker(j).x+1][worker(j).y]=1;
          worker(j).move_right();
        }
        else if RESULTS[j][0]==3 {
          info(`worker ${j} moves to [${worker(j).x-1},${worker(j).y}]`);
          M[worker(j).x-1][worker(j).y]=1;
          worker(j).move_left();
      } else {
      if(max>0){
      if(a>b) eficaz=j;
      else eficaz=i;
      if RESULTS[eficaz][0]==0 {
        info(`worker ${w} moves to [${worker(w).x},${worker(w).y+1}]`);
        M[worker(w).x][worker(w).y+1]=1;
        worker(w).move_up();
      }
      else if RESULTS[eficaz][0]==1 {
        info(`worker ${w} moves to [${worker(w).x},${worker(w).y-1}]`);
        M[worker(w).x][worker(w).y-1]=1;
        worker(w).move_down();
      }
      else if RESULTS[eficaz][0]==2 {
        info(`worker ${w} moves to [${worker(w).x+1},${worker(w).y}]`);
        M[worker(w).x+1][worker(w).y]=1;
        worker(w).move_right();
      }
      else if RESULTS[eficaz][0]==3 {
        info(`worker ${w} moves to [${worker(w).x-1},${worker(w).y}]`);
        M[worker(w).x-1][worker(w).y]=1;
        worker(w).move_left();
      }
      if(i==eficaz){
      ineficaz=j;}
      else{
      ineficaz=i;
      }
      M[map.worker(ineficaz).x][map.worker(ineficaz).y]=1
      2plato=RESULTS[w]=direction(map,w,d,work_a,M,resultat_c,dist_c);}
      if 2plato[0]==0 {
        info(`worker ${ineficaz} moves to [${worker(ineficaz).x},${worker(ineficaz).y+1}]`);
        M[worker(ineficaz).x][worker(ineficaz).y+1]=1;
        worker(ineficaz).move_up();
      }
      else if 2plato[0]==1 {
        info(`worker ${ineficaz} moves to [${worker(ineficaz).x},${worker(ineficaz).y-1}]`);
        M[worker(ineficaz).x][worker(ineficaz).y-1]=1;
        worker(ineficaz).move_down();
      }
      else if 2plato[0]==2 {
        info(`worker ${ineficaz} moves to [${worker(w).x+1},${worker(w).y}]`);
        M[worker(ineficaz).x+1][worker(ineficaz).y]=1;
        worker(ineficaz).move_right();
      }
      else if 2plato[0]==3 {
        info(`worker ${ineficaz} moves to [${worker(ineficaz).x-1},${worker(ineficaz).y}]`);
        M[worker(ineficaz).x-1][worker(ineficaz).y]=1;
        worker(ineficaz).move_left();
      }
  }
}
