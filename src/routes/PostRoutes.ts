import { Router } from "express";

import PostController from "../controllers/PostController";

const router = Router();

router.get("/", PostController.listAll);

router.get("/:id", PostController.getOne);

router.post("/", PostController.addOne);

router.put("/:id", PostController.updateRecord);

router.delete("/:id", PostController.destroy);

export default router;
