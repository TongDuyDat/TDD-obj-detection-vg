# YOLOv8 on Visual Genoem Dataset

## Giới Thiệu


## Môi Trường Cài Đặt

Để cài đặt môi trường làm việc cho dự án này, bạn cần làm theo các bước sau:

1. **Clone repository**

    ```bash
    git clone https://github.com/TongDuyDat/TDD-obj-detection-vg.git
    cd TDD-obj-detection-vg
    ```

2. **Tạo môi trường ảo**

    MMYOLO relies on PyTorch, MMCV, MMEngine, and MMDetection. Below are quick steps for installation. Please refer to the [Install Guide](docs/en/get_started/installation.md) for more detailed instructions.

```shell
conda create -n mmyolo python=3.8 pytorch==1.10.1 torchvision==0.11.2 cudatoolkit=11.3 -c pytorch -y
conda activate mmyolo
pip install openmim
mim install "mmengine>=0.6.0"
mim install "mmcv>=2.0.0rc4,<2.1.0"
mim install "mmdet>=3.0.0,<4.0.0"
git clone https://github.com/open-mmlab/mmyolo.git
cd mmyolo
# Install albumentations
pip install -r requirements/albu.txt
# Install MMYOLO
mim install -v -e .
```


## Tải Dữ Liệu

```shell
cd mmyolo
bash make_data.sh
```
## Huấn Luyện Mô Hình


```shell
python tools/train.py configs/yolov8/custom_train_vg_yolov8_500e_coco.py
```