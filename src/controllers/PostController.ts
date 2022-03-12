import { Request, Response } from "express";
const db = require("../database/mysql-connection");

const default_user = 1;

const getOne = async (req: Request, res: Response) => {
  const id = req.params.id;
  const [[result]]: any = await dbQuery(
    "CALL `spPostGet`(?, ?, ?, ?, ?, ?, ?);",
    [id, null, null, null, null, null, null]
  );
  res.send({
    data: result,
  });
};

const addOne = async (req: Request, res: Response) => {
  const body = req.body;
  const title = body.title ? body.title : "";
  const content = body.content ? body.content : "";

  const result = await dbQuery("CALL `spPostAdd`(?, ?, ?);", [
    title,
    content,
    default_user,
  ]);

  res.send({
    message: result,
  });
};

const listAll = async (req: Request, res: Response) => {
  const id = req.query.id ? req.query.id : null;
  const search = req.query.search ? req.query.search : null;
  const offset = req.query.offset ? req.query.offset : null;
  const rows = req.query.rows ? req.query.rows : null;
  const sortCol = req.query.sortCol ? req.query.sortCol : null;
  const sortDir = req.query.sortDir ? req.query.sortDir : null;
  const countOnly = req.query.countOnly ? req.query.countOnly : null;

  const [result]: any = await dbQuery(
    "CALL `spPostGet`(?, ?, ?, ?, ?, ?, ?);",
    [id, search, offset, rows, sortCol, sortDir, countOnly]
  );

  res.send({
    data: result,
  });
};

const destroy = async (req: Request, res: Response) => {
  const id = req.params.id;
  const body = req.body;
  const title = body.title ? body.title : null;
  const content = body.content ? body.content : null;
  const deleted = true;
  const updateAll = false;
  if (!id)
    return res.send({
      message: "No id",
    });

  const result: any = await dbQuery("CALL `spPostUpdate`(?, ?, ?, ?, ?);", [
    id,
    title,
    content,
    deleted,
    updateAll,
  ]);

  res.send({
    data: result,
  });
};

const updateRecord = async (req: Request, res: Response) => {
  const id = req.params.id;
  const body = req.body;
  const title = body.title ? body.title : null;
  const content = body.content ? body.content : null;
  const deleted = false;
  const updateAll = false;
  if (!id)
    return res.send({
      message: "No id",
    });

  const result: any = await dbQuery("CALL `spPostUpdate`(?, ?, ?, ?, ?);", [
    id,
    title,
    content,
    deleted,
    updateAll,
  ]);

  res.send({
    data: result,
  });
};

function dbQuery(query: any, param: any) {
  return new Promise(function (resolve, reject) {
    db.query(query, param, function (err: any, rows: any, fields: any) {
      if (err) {
        return reject(err);
      }
      resolve(rows);
    });
  });
}

const PostController = {
  addOne,
  getOne,
  listAll,
  updateRecord,
  destroy,
};

export default PostController;
