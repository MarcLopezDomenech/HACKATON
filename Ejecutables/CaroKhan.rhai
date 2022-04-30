for w in map.workers {
    // Logic to check worker placement
}

for x in 0..40 {
    for y in 0..40 {
        if map[x][y] == Tile::EMPTY {
            // more logic
        }
        // other logic
    }
}

for w in 0..3 {
    let r = (rand() % 4).abs();
    x=worker(w).x
    y=worker(w).y
    if y<=2*x {
    switch r {
        0 => worker(w).move_up(),
        1 => worker(w).move_down(),
        2 => worker(w).move_right(),
        3 => worker(w).move_left(),
    }
    }
    else{
      if y!=39{
        worker(w).move_up()
      }
      else{
        worker(w).move_down()
      }
    }
}

for w in 3..5 {
    let r = (rand() % 4).abs();
    x=worker(w).x
    y=worker(w).y
    if y>=2*x {
      worker(w).move_right()}
    else if x>=2*y{
      worker(w).move_left()}
    else{
    switch r {
        0 => worker(w).move_up(),
        1 => worker(w).move_down(),
        2 => worker(w).move_right(),
        3 => worker(w).move_left(),
    }
    }
}
for w in 5..8 {
    let r = (rand() % 4).abs();
    x=worker(w).x
    y=worker(w).y
    else if 2*y>=x{
      worker(w).move_left()}
    else{
    switch r {
        0 => worker(w).move_up(),
        1 => worker(w).move_down(),
        2 => worker(w).move_right(),
        3 => worker(w).move_left(),
    }
    }
}
}
