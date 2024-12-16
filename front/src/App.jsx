// hooks
import { useState, useEffect } from "react";
// importaciones
import "./App.css";
import Casilla from "./componnets/Casilla";
import Empate from "./componnets/Empate";
import Win from "./componnets/Win";
import { TURNS } from "./variables";
import { detectEmpate, detectWinner } from "./logic";

function App() {
  const [turnoActual, setturnoActual] = useState(TURNS.O);
  const [listCasillas, setlistCasillas] = useState(Array(9).fill(null));
  const [win, setWin] = useState(false);
  const [empate, setEmpate] = useState(false);

  useEffect(() => {
    try {
      const game = JSON.parse(window.localStorage.getItem("partida"));
      setlistCasillas(game.jugadas);
      setturnoActual(game.turno);
      setWin(game.winner);
      console.log(game.winner);
    } catch {
      console.log();
    }
  }, []);

  let modal;

  const handleClick = (index) => {
    if (listCasillas[index] != null && !win) return null;

    const turno = turnoActual === TURNS.O ? TURNS.X : TURNS.O;
    setturnoActual(turno);

    const newListaCasillas = [...listCasillas];
    newListaCasillas[index] = turnoActual;
    setlistCasillas(newListaCasillas);

    const iswin = detectWinner(newListaCasillas, turnoActual);

    setWin(iswin);
    setEmpate(detectEmpate(newListaCasillas));

    // guardamos la informacion de la partida actual en el localStorage
    const partida = {
      jugadas: newListaCasillas,
      turno: turno,
      winner: iswin,
    };

    window.localStorage.setItem("partida", JSON.stringify(partida));
  };

  const resetGame = () => {
    setWin(false);
    setEmpate(false);
    setlistCasillas(Array(9).fill(null));
    setturnoActual(TURNS.O);

    const partida = {
      jugadas: Array(9).fill(null),
      turno: TURNS.O,
      winner: false,
    };

    window.localStorage.setItem("partida", JSON.stringify(partida));
  };

  if (win) {
    modal = (
      <Win action={resetGame} isWin={win} turnoActual={turnoActual}>
        Ha ganado
      </Win>
    );
  } else {
    modal = (
      <Empate action={resetGame} isEmpate={empate}>
        {" "}
        Ha sido un empate{" "}
      </Empate>
    );
  }

  return (
    <>
      {modal}
      <div className="container">
        <h1>Tic Tac Toe</h1>
        <div className="juego">
          {listCasillas.map((casilla, index) => {
            return (
              <Casilla key={index} numeroCasilla={index} onAction={handleClick}>
                {casilla}
              </Casilla>
            );
          })}
        </div>
        <footer className="turnos">
          <Casilla isTurn={turnoActual == TURNS.X}>X</Casilla>
          <Casilla isTurn={turnoActual == TURNS.O}>O</Casilla>
        </footer>
      </div>
    </>
  );
}

export default App;
