//Funció que retorna un vector amb la puntuació de cada color:
//Puntuació=[verd, groc, vermell, blau]
fn puntuacio(){
    let Puntuacio=[0,0,0,0];
    for x in 0..40 {
        for y in 0..40 {
            if map[x][y] == Tile::GREEN {
                Puntacio[0]+=1
              }
            if map[x][y] == Tile::YELLOW {
                Puntacio[1]+=1
              }
            if map[x][y] == Tile::RED {
                Puntacio[2]+=1
              }
            if map[x][y] == Tile::BLUE {
                Puntacio[3]+=1
              }
            }
        }
    Puntacio
}

//Retorna si en la posició (x,y) es enemiga
fn casilla_enemiga(x,y,map){
  if map[x][y]!=Tile::EMPTY && map[x][y]!=map.mycolor(){
      return true;
  }
  return false;
}

//Retorna si en la posició (x,y) es buida
fn casilla_buida(x,y){
  if map[x][y]==Tile::EMPTY{
      return true;
  }
  return false;
}

//Retorna si en la posició (x,y) hi ha un worker
fn can_move(x,y,work_ar){
  for w in work_ar{
    if w.x==x && w.y==y{
      false
    }
  }
  true
}

//Modifica la posició del worker a la posició (x,y) en la posició (x1,y1)
//work_a=map.workers
fn move(x,y,work_a,x1,y1){
  for w in map.work_a{
    if w.x==x && w.y==y{
      w.x=x1;
      w.y=x2;
      break
    }
  }
}

//Da si(x,y) es una posición valida
fn valid_pos(x,y){
  if x<40 && x>=0 & y>=0 && y<40{
    true
  }
  false
}
fn connect(worker, w1,w2){
  let c1 = component(w1);
  let c2 = component(w2);
  if c1 != c2{
    if(worker(w1).x < worker(w2).x){
        worker(w1).move_right();
        worker(w2).move_left();
    } else if worker(w1).x > worker(w2).x{
        worker(w1).move_left();
        worker(w2).move_right();
    } else if worker(w1).y > worker(w2).y{
        worker(w1).move_down();
        worker(w1).move_up();
    }   else{
        worker(w2).move_down();
        worker(w1).move_up();
    }
  }
}

/* Desactualizado
//Retorna si en la posició (x,y) hi ha un worker
fn can_move(x,y){
  for w in map.workers{
    if w.x==x & w.y==y{
      false
    }
  }
  true
}

fn direction_OBJ(map,w,d,work_a,M){
result=[0,0,0] //=[ins, xobj, yobj]
  if d>40{
    info(`function fails`);
    return [1, 0, 0]
  }

  let our_color=w.color;
  let result[0]=4;
  let x=w.x;
  let y=w.y;
  for i in 0..d{
    //Primer quadrant
    if should_move(map,x+d-i,y+i,our_color,work_a,M) {
      if map[x+d-i][y+i] == Tile::EMPTY {
      result=[2, x+d-i, y+i]
      } else {
        //info(`it moves ${2}`);
        return result
      }
    }
    //Quart quadrant
    if should_move(map,x+d-i,y-i,our_color,work_a,M) {
      if map[x+d-i][y-i] == Tile::EMPTY {
        result=[2, x+d-i, y-i]
      } else {
        //info(`it moves ${2}`);
        return result
      }
    }
    //Segon quadrant
    if should_move(map,x-d+i,y+i,our_color,work_a,M) {
      if map[x-d+i][y+i] == Tile::EMPTY {
        result=[2, x-d+i, y+i]
      } else {
        //info(`it moves ${3}`);
        return result
      }
    }
    //Tercer quadrant
    if should_move(map,x-d+i,y-i,our_color,work_a,M){
      if map[x-d+i][y-i] == Tile::EMPTY {
        result=[3, x-d+i, y-i]
      } else {
        //info(`it moves ${3}`);
        return result
      }
    }
  }
  if should_move(map,x,y+d,our_color,work_a,M) {
    if map[x][y+d] == Tile::EMPTY {
      result =[0, x, y+d];
    } else {
      //info(`it moves ${0}`);
      return result
    }
  }
  if should_move(map,x,y-d,our_color,work_a,M) {
    //info(`it moves ${1}`);
    return [1, x, y-d]
  }
  if result[0]<4{
    //info(`it moves ${result}`);
    return result
  }
  direction(map,w,d+1,work_a,M)
}

//nx8x2, suponiendo se hace caso a direccion
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
sobran(i, j, eps, Obj){
d=(Obj[i][0]-Obj[j][0])*(Obj[i][0]-Obj[j][0])+(Obj[i][1]-Obj[j][1])*(Obj[i][1]-Obj[j][1]))
solapan= d2<eps*eps;
ij=(Obj[i][0]-Obj[j][0])*(Obj[i][0]-Obj[j][0])-(Obj[i][1]-Obj[j][1])*(Obj[i][1]-Obj[j][1]))
if (ij>0){
ij=1
}
else{
ij=-1
}
return ij*solapan;
}
// que hacer con ignorado
// extender a más de dos y en función de distancia

}


*/
