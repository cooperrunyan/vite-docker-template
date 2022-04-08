import React, { type ReactChild } from 'react';
import style from './Container.module.scss';

interface Props {
  children: ReactChild;
}

export const Container: React.FC<Props> = ({ children }: Props) => {
  return <div className={style.Container}>{children}</div>;
};
