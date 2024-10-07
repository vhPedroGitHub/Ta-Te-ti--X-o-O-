import { useEffect, useState } from "react";
import "./App.css";

const TURNS = {
  X: "X",
  O: "O",
};

const COMBINACIONES = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6],
];

function Win({ children, turnoActual, action, isWin }) {
  return (
    <>
      <section className={`win win-${isWin ? "on" : "off "}`}>
        <span>{children}</span>
        <Casilla>{turnoActual === TURNS.O ? TURNS.X : TURNS.O}</Casilla>
        <button onClick={action}>Reiniciar Juego</button>
      </section>
    </>
  );
}

function Empate({ children, action, isEmpate }) {
  return (
    <>
      <section className={`win win-${isEmpate ? "on" : "off "}`}>
        <span>{children}</span>
        <button onClick={action}>Reiniciar Juego</button>
      </section>
    </>
  );
}

function Casilla({ children, numeroCasilla, isTurn, onAction }) {
  return (
    <>
      <div
        className={`cs-${numeroCasilla} cs cs-${isTurn ? "on" : "off"}`}
        onClick={() => onAction(numeroCasilla)}
      >
        {children}
      </div>
    </>
  );
}

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
