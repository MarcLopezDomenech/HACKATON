
for w in 0..8 {
    let x=worker(w).x;
    let y=worker(w).y;
    if (y%2).abs==1{
      worker(w).move_right();
      if x==39 {
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
