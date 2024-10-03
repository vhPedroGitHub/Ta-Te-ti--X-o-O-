import Card, { CardBody } from "./components/Card";
import List from "./components/List";

function App() {
  const list = ["Goky", "Enjiro", "Eren"];
  return (
    <>
      <Card>
        <CardBody text="Hola esto es Reac" title="este es el titulo" />
        <List data={list} />
      </Card>
    </>
  );
}

export default App;
