import { useEffect, useState } from "react";
import "./App.css";

function Casilla({
  campos,
  setCampos,
  numeroCasilla,
  turnoAnterior,
  setturnoAnterior,
  listCasillas,
  setlistCasillas,
}) {
  let [campo, setCampo] = useState(" ");

  const handleClick = () => {
    if (campo === " ") {
      if (turnoAnterior == "X") {
        setCampo("O");
        setturnoAnterior("O");
      } else {
        setCampo("X");
        setturnoAnterior("X");
      }
      listCasillas[numeroCasilla] = turnoAnterior == "X" ? "O" : "X";
      setlistCasillas(listCasillas);
    }
    setCampos(" ");
  };

  useEffect(() => {
    if (campos == "O") {
      setCampo(" ");
    }
  }, [campos]);

  return (
    <>
      <div className={`cs-${numeroCasilla} cs`} onClick={handleClick}>
        {campo}
      </div>
    </>
  );
}

function App() {
  const casillas = [" ", " ", " ", " ", " ", " ", " ", " ", " "];
  const [turnoAnterior, setturnoAnterior] = useState("X");
  const [listCasillas, setlistCasillas] = useState(casillas);
  const [campos, setCampos] = useState(" ");

  if (
    (listCasillas[0] == turnoAnterior &&
      listCasillas[1] == turnoAnterior &&
      listCasillas[2] == turnoAnterior) ||
    (listCasillas[3] == turnoAnterior &&
      listCasillas[4] == turnoAnterior &&
      listCasillas[5] == turnoAnterior) ||
    (listCasillas[6] == turnoAnterior &&
      listCasillas[7] == turnoAnterior &&
      listCasillas[8] == turnoAnterior) ||
    (listCasillas[0] == turnoAnterior &&
      listCasillas[4] == turnoAnterior &&
      listCasillas[8] == turnoAnterior) ||
    (listCasillas[2] == turnoAnterior &&
      listCasillas[4] == turnoAnterior &&
      listCasillas[6] == turnoAnterior) ||
    (listCasillas[0] == turnoAnterior &&
      listCasillas[3] == turnoAnterior &&
      listCasillas[6] == turnoAnterior) ||
    (listCasillas[1] == turnoAnterior &&
      listCasillas[4] == turnoAnterior &&
      listCasillas[7] == turnoAnterior) ||
    (listCasillas[2] == turnoAnterior &&
      listCasillas[5] == turnoAnterior &&
      listCasillas[8] == turnoAnterior)
  ) {
    setCampos("O");
    setlistCasillas(casillas);
    setturnoAnterior("X");
  }

  const cass = listCasillas.map((casilla, index) => {
    return (
      <Casilla
        campos={campos}
        setCampos={setCampos}
        numeroCasilla={index}
        turnoAnterior={turnoAnterior}
        setturnoAnterior={setturnoAnterior}
        listCasillas={listCasillas}
        setlistCasillas={setlistCasillas}
      />
    );
  });

  return (
    <div className="container">
      <div className="juego">{cass}</div>
    </div>
  );
}

export default App;
