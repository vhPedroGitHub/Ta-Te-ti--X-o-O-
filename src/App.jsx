import { useState } from "react";
import "./App.css";
import Casilla from "./componnets/Casilla";
import Empate from "./componnets/Empate";
import Win from "./componnets/Win";
import { TURNS, COMBINACIONES } from "./constants";

function App() {
  const [turnoActual, setturnoActual] = useState(TURNS.O);
  const [listCasillas, setlistCasillas] = useState(Array(9).fill(null));
  const [win, setWin] = useState(false);
  const [empate, setEmpate] = useState(false);

  let modal;

  const handleClick = (index) => {
    if (listCasillas[index] != null || win) return null;

    setturnoActual(turnoActual === TURNS.O ? TURNS.X : TURNS.O);

    const newListaCasillas = [...listCasillas];
    newListaCasillas[index] = turnoActual;
    setlistCasillas(newListaCasillas);

    setWin(detectWinner(newListaCasillas));
    setEmpate(detectEmpate(newListaCasillas));
  };

  const detectWinner = (casillasJugadas) => {
    for (const combinacion of COMBINACIONES) {
      const [a, b, c] = combinacion;

      if (
        casillasJugadas[a] === casillasJugadas[b] &&
        casillasJugadas[a] === casillasJugadas[c] &&
        casillasJugadas[a] === turnoActual
      )
        return true;
    }
    return false;
  };

  const detectEmpate = (casillasJugadas) => {
    return casillasJugadas.every((casilla) => casilla != null) ? true : false;
  };

  const resetGame = () => {
    setWin(false);
    setEmpate(false);
    setlistCasillas(Array(9).fill(null));
    setturnoActual(TURNS.O);
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
