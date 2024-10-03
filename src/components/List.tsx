import { useState } from "react";

type Props = {
  data: string[];
};

export default function List({ data }: Props) {
  const [index, setIndex] = useState(-1);

  const handleClick = (i: number) => {
    setIndex(i);
  };

  return (
    <div>
      <ul className="list-group">
        {data.map((element, i) => (
          <li
            onClick={() => handleClick(i)}
            key={element}
            className={`list-group-item ${i == index ? "active" : ""}`}
          >
            {element}
          </li>
        ))}
      </ul>
    </div>
  );
}
