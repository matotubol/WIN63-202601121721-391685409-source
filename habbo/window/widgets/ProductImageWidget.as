package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.enum.PivotPoint;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.theme.class_2458;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.class_2201;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.window.utils.EffectPreviewer;
   import com.sulake.habbo.window.utils.class_3988;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   
   public class ProductImageWidget implements class_1902, class_1829
   {
      
      public static const TYPE:String = "product_image";
      
      private var var_1824:Number;
      
      private var var_210:class_2010;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_988:EffectPreviewer;
      
      private var var_134:class_1812;
      
      private var _disposed:Boolean;
      
      private var var_3050:IProductDisplayInfo;
      
      private var var_1605:uint;
      
      private var var_916:Number = 1;
      
      private var var_4167:int = -1;
      
      private var var_4339:String = "";
      
      private var var_780:int = 0;
      
      public function ProductImageWidget(param1:class_2010, param2:HabboWindowManagerComponent)
      {
         super();
         var_210 = param1;
         _windowManager = param2;
         var_134 = class_1812(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("product_image_xml").content)));
         var_988 = new EffectPreviewer(effectImageWidget,param2.avatarRenderer);
         var_210.rootWindow = var_134;
         var_134.width = var_210.width;
         var_134.height = var_210.height;
         setPlaceholder();
      }
      
      public function set productInfo(param1:IProductDisplayInfo) : *
      {
         var_3050 = param1;
         previewImage(param1);
      }
      
      public function get productInfo() : IProductDisplayInfo
      {
         return var_3050;
      }
      
      public function get properties() : Array
      {
         var _loc2_:Array = [];
         if(_disposed)
         {
            return _loc2_;
         }
         var _loc1_:class_2458 = _windowManager.getThemeManager().getPropertyDefaults(var_210.style);
         _loc2_.push(_loc1_.method_20("pivot_point").withValue(PivotPoint.PIVOT_NAMES[var_1605]));
         return _loc2_;
      }
      
      public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            var _loc3_:* = _loc2_.key;
            if("pivot_point" === _loc3_)
            {
               pivot = PivotPoint.pivotFromName(String(_loc2_.value));
            }
         }
      }
      
      public function get pivot() : uint
      {
         return var_1605;
      }
      
      public function set pivot(param1:uint) : void
      {
         var_1605 = param1;
         (productPreviewBitmap as class_2201).pivotPoint = param1;
         (badgeImageWidget.widget as BadgeImageWidget).pivotPoint = param1;
         placeholderImage.pivotPoint = param1;
         refresh();
      }
      
      private function refresh() : void
      {
         if(var_3050 != null)
         {
            previewImage(var_3050);
         }
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function previewImage(param1:IProductDisplayInfo) : void
      {
         var _loc6_:String = null;
         var _loc3_:class_1800 = null;
         _loc3_ = null;
         var _loc2_:class_2198 = null;
         var _loc4_:BitmapData = null;
         if(param1 == null)
         {
            setUnknownImage();
            return;
         }
         if(handlePreviewImageEasterEgg(param1))
         {
            return;
         }
         switch(param1.productTypeId - -1)
         {
            case 0:
               setUnknownImage();
               break;
            case 1:
               _loc3_ = _windowManager.sessionDataManager.getWallItemData(parseInt(param1.itemTypeId));
               if(_loc3_ == null)
               {
                  clearPreviewer();
                  break;
               }
               var _loc5_:int = class_3988.categoryMapping("I",_loc3_.id);
               if(_loc5_ == 1)
               {
                  imageResult = _windowManager.roomEngine.getWallItemImage(_loc3_.id,new Vector3d(90),64,this);
                  break;
               }
               clearPreviewer();
               break;
            case 2:
               _loc3_ = _windowManager.sessionDataManager.getFloorItemData(parseInt(param1.itemTypeId));
               if(_loc3_ == null)
               {
                  clearPreviewer();
                  break;
               }
               imageResult = _windowManager.roomEngine.getFurnitureImage(_loc3_.id,new Vector3d(90,0,0),64,this);
               break;
            case 3:
               if(param1.itemTypeId == "")
               {
                  clearPreviewer();
                  break;
               }
               setEffectResult(_windowManager.sessionDataManager.figure,parseInt(param1.itemTypeId));
               break;
            case 5:
               badgeResult = param1.itemTypeId;
               break;
            case 10:
               _loc2_ = new class_2198();
               _loc4_ = class_3988.createChatItemPreview(_windowManager,parseInt(param1.itemTypeId));
               if(_loc4_ == null)
               {
                  clearPreviewer();
                  break;
               }
               _loc2_.data = _loc4_;
               imageResult = _loc2_;
               break;
            case 11:
               petResult = param1.petFigureString;
               break;
            case 12:
               avatarResult = _loc6_ = _windowManager.avatarRenderer.getFigureStringWithFigureIds(_windowManager.sessionDataManager.figure,_windowManager.sessionDataManager.gender,param1.figureSetIds);
               break;
            default:
               class_21.log("[ProductImageWidget] Can not yet handle this type of product: ");
               clearPreviewer();
         }
      }
      
      private function handlePreviewImageEasterEgg(param1:IProductDisplayInfo) : Boolean
      {
         if(param1.productTypeId == var_4167 && param1.itemTypeId == var_4339)
         {
            var_780 += 1;
         }
         else
         {
            var_780 = 1;
         }
         var_4167 = param1.productTypeId;
         var_4339 = param1.itemTypeId;
         if(param1.productTypeId == 9)
         {
            var _loc4_:String = "";
            if(var_780 == 7)
            {
               _loc4_ = "Evil Frank";
            }
            if(var_780 == 10)
            {
               _loc4_ = "Bonne Blonde";
            }
            if(var_780 == 15)
            {
               _loc4_ = "Furni fairy";
            }
            if(var_780 == 22)
            {
               _loc4_ = "Wacky Wired";
            }
            if(var_780 == 35)
            {
               _loc4_ = "Quacky duck";
            }
            if(var_780 == 70)
            {
               _loc4_ = "Pixel poo";
            }
            if(var_780 == 100)
            {
               _loc4_ = "Bobba filtered";
            }
            var _loc2_:class_2198 = new class_2198();
            var _loc3_:BitmapData = class_3988.createChatItemPreview(_windowManager,parseInt(param1.itemTypeId),null);
            return false;
         }
         return false;
      }
      
      public function clearPreviewer() : void
      {
         var_1824 = -1;
         avatarImageWidget.visible = false;
         productPreviewBitmap.visible = false;
         badgeImageWidget.visible = false;
         placeholderImage.visible = false;
         petImageWidget.visible = false;
         var_988.visible = false;
         unknownImageWindow.visible = false;
      }
      
      private function set imageResult(param1:class_2198) : void
      {
         clearPreviewer();
         if(param1 != null)
         {
            var_1824 = param1.id;
            setPreviewImage(param1.data);
         }
      }
      
      private function centerWindow(param1:class_2010) : void
      {
         param1.x = var_134.width / 2 - param1.width / 2;
         param1.y = var_134.height / 2 - param1.height / 2;
      }
      
      private function set avatarResult(param1:String) : void
      {
         clearPreviewer();
         avatarImageWidget.visible = true;
         var _loc2_:class_2478 = avatarImageWidget.widget as class_2478;
         _loc2_.figure = param1;
         centerWindow(avatarImageWidget);
      }
      
      private function set badgeResult(param1:String) : void
      {
         clearPreviewer();
         badgeImageWidget.visible = true;
         var _loc2_:class_3087 = badgeImageWidget.widget as class_3087;
         _loc2_.badgeId = param1;
      }
      
      private function set petResult(param1:String) : void
      {
         clearPreviewer();
         petImageWidget.visible = true;
         var _loc2_:class_3567 = petImageWidget.widget as class_3567;
         _loc2_.figure = param1;
      }
      
      private function setEffectResult(param1:String, param2:int) : void
      {
         clearPreviewer();
         centerWindow(effectImageWidget);
         effectImageWidget.y += 50;
         var_988.visible = true;
         var_988.update(param1,param2);
      }
      
      private function setUnknownImage() : void
      {
         clearPreviewer();
         unknownImageWindow.visible = true;
      }
      
      public function setPlaceholder() : void
      {
         clearPreviewer();
         placeholderImage.visible = true;
      }
      
      private function setPreviewImage(param1:BitmapData) : void
      {
         if(productPreviewBitmap == null)
         {
            return;
         }
         if(param1 == null)
         {
            productPreviewBitmap.visible = false;
            return;
         }
         productPreviewBitmap.bitmap = param1.clone();
         productPreviewBitmap.visible = true;
      }
      
      public function set blend(param1:Number) : *
      {
         var_916 = param1;
         productPreviewBitmap.blend = blend;
         unknownImageWindow.blend = blend;
         badgeImageWidget.blend = blend;
         petImageWidget.blend = blend;
         (petImageWidget.widget as class_3567).refresh();
         (badgeImageWidget.widget as class_3087).refresh();
      }
      
      public function get blend() : Number
      {
         return var_916;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(var_1824 == param1 && productPreviewBitmap != null)
         {
            setPreviewImage(param2);
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(var_988 != null)
         {
            var_988.dispose();
            var_988 = null;
         }
         var_1824 = -1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get placeholderImage() : IStaticBitmapWrapperWindow
      {
         return var_134.findChildByName("placeholder_image") as IStaticBitmapWrapperWindow;
      }
      
      private function get productPreviewBitmap() : class_2251
      {
         return var_134.findChildByName("product_preview") as class_2251;
      }
      
      private function get avatarImageWidget() : class_2010
      {
         return var_134.findChildByName("avatar_image_widget") as class_2010;
      }
      
      private function get badgeImageWidget() : class_2010
      {
         return var_134.findChildByName("badge_image_widget") as class_2010;
      }
      
      private function get petImageWidget() : class_2010
      {
         return var_134.findChildByName("pet_image_widget") as class_2010;
      }
      
      private function get effectImageWidget() : class_2010
      {
         return var_134.findChildByName("effect_image_widget") as class_2010;
      }
      
      private function get unknownImageWindow() : IStaticBitmapWrapperWindow
      {
         return var_134.findChildByName("unknown_image") as IStaticBitmapWrapperWindow;
      }
   }
}

