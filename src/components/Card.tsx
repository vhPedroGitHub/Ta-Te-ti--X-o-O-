import { ReactNode } from "react";

type Props = {
  children: ReactNode;
};

function Card(props: Props) {
  const { children } = props;
  return (
    <div className="card" style={{ width: "250px" }}>
      {children}
    </div>
  );
}

type CardBodyProps = {
  title: string;
  text: string;
};

export function CardBody(props: CardBodyProps) {
  const { title, text } = props;
  return (
    <>
      <h5 className="card-title">{title}</h5>
      <p className="card-text">{text}</p>
      <a href="#" className="card-link">
        Card link
      </a>
    </>
  );
}

export default Card;
