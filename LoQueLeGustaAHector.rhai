
for w in 0..8 {
    let x=worker(w).x;
    let y=worker(w).y;
    if (y%2).abs()==1{
      worker(w).move_right();
<<<<<<< HEAD
      if x==49 {
=======
      if x==39 {
>>>>>>> faf63c670be64aad02a80dc8ce1c7057ed942370
        worker(w).move_down();
      }
    } else {
      worker(w).move_left();
      if x==0 {
        worker(w).move_down();
      }
    }
      info(`worker ${w} finished`);
  }
