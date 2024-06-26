# Copyright (c) OpenMMLab. All rights reserved.
import os
from typing import Any, Optional

from mmdet.datasets import BaseDetDataset, CocoDataset

from ..registry import DATASETS, TASK_UTILS


class BatchShapePolicyDataset(BaseDetDataset):
    """Dataset with the batch shape policy that makes paddings with least
    pixels during batch inference process, which does not require the image
    scales of all batches to be the same throughout validation."""

    def __init__(self,
                 *args,
                 batch_shapes_cfg: Optional[dict] = None,
                 **kwargs):
        self.batch_shapes_cfg = batch_shapes_cfg
        super().__init__(*args, **kwargs)

    def full_init(self):
        """rewrite full_init() to be compatible with serialize_data in
        BatchShapePolicy."""
        if self._fully_initialized:
            return
        # load data information
        self.data_list = self.load_data_list()

        # batch_shapes_cfg
        if self.batch_shapes_cfg:
            batch_shapes_policy = TASK_UTILS.build(self.batch_shapes_cfg)
            self.data_list = batch_shapes_policy(self.data_list)
            del batch_shapes_policy

        # filter illegal data, such as data that has no annotations.
        self.data_list = self.filter_data()
        # Get subset data according to indices.
        if self._indices is not None:
            self.data_list = self._get_unserialized_subset(self._indices)

        # serialize data_list
        if self.serialize_data:
            self.data_bytes, self.data_address = self._serialize_data()

        self._fully_initialized = True

    def prepare_data(self, idx: int) -> Any:
        """Pass the dataset to the pipeline during training to support mixed
        data augmentation, such as Mosaic and MixUp."""
        if not self.test_mode:
            data_info = self.get_data_info(idx)
            data_info['dataset'] = self
            if 'img_path' not in data_info:
                data_info['img_path'] = self.get_img_path(idx)
                print("Run 54 ..........................................")
            # Debugging output
            # print(f"Preparing data for idx {idx}: img_path = {data_info['img_path']}")

            result = self.pipeline(data_info)
            
            # Debugging output after pipeline
            # print(f"Data after pipeline for idx {idx}: img_path = {result.get('img_path', 'Key not found')}")

            return result
        else:
            print("Run 60 ..........................................")
            return super().prepare_data(idx)
        
    def get_img_path(self, idx):
        # Construct the image path based on the index and dataset structure
        return os.path.join(self.img_prefix, self.data_infos[idx]['filename'])

@DATASETS.register_module()
class YOLOv5CocoDataset(BatchShapePolicyDataset, CocoDataset):
    """Dataset for YOLOv5 COCO Dataset.

    We only add `BatchShapePolicy` function compared with CocoDataset. See
    `mmyolo/datasets/utils.py#BatchShapePolicy` for details
    """
    pass
