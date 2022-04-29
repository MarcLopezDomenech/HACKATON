""
    "Estratègia de prova"
    ""

    fn
    puntuacio()
{
    let Puntuacio=[0,0,0,0]
    for x in 0..40
    {
        for
            y in 0..40
            {
                if map
                    [x][y] == Tile::GREEN
                    {
                        Puntacio[0] += 1;
                    }
                if map
                    [x][y] == Tile::YELLOW
                    {
                        Puntacio[1] += 1;
                    }
                if map
                    [x][y] == Tile::RED
                    {
                        Puntacio[2] += 1;
                    }
                if map
                    [x][y] == Tile::BLUE
                    {
                        Puntacio[3] += 1;
                    }
#other logic
            }
    }
    Puntacio
}
for
    w in map.workers
    {
        // Logic to check worker placement
    }
info(puntuacio);
for
    x in 0..40
    {
    for
        y in 0..40
        {
            if map
                [x][y] == Tile::EMPTY
                {
                    // more logic
                }
            // other logic
        }
    }
for
    w in 0..8
    {
        let r = (rand() % 4).abs();
        switch
            r {
                0 = > worker(w).move_up(),
                1 = > worker(w).move_down(),
                2 = > worker(w).move_right(),
                3 = > worker(w).move_left(),
            }

            info(`worker $ { w } finished`);
    }
