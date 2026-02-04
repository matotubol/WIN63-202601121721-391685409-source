package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.catalog.purse.class_2085;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.window.utils.class_3988;
   import flash.display.BitmapData;
   
   public class ProductIconWidget implements class_2343, class_1829
   {
      
      public static const TYPE:String = "product_icon";
      
      private var var_1824:Number;
      
      private var var_210:class_2010;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_134:class_1812;
      
      private var _disposed:Boolean;
      
      private var var_3050:IProductDisplayInfo;
      
      private var var_916:Number;
      
      public function ProductIconWidget(param1:class_2010, param2:HabboWindowManagerComponent)
      {
         super();
         var_210 = param1;
         _windowManager = param2;
         var_134 = class_1812(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("product_icon_xml").content)));
         var_210.rootWindow = var_134;
         clearPreviewer();
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
         return [];
      }
      
      public function set properties(param1:Array) : void
      {
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function previewImage(param1:IProductDisplayInfo) : void
      {
         var _loc3_:class_1800 = null;
         _loc3_ = null;
         var _loc2_:class_2198 = null;
         var _loc5_:int = 0;
         _loc2_ = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         if(param1 == null)
         {
            setUnknownImage();
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
               var _loc4_:int = class_3988.categoryMapping("I",_loc3_.id);
               if(_loc4_ == 1)
               {
                  imageResult = _windowManager.roomEngine.getWallItemIcon(_loc3_.id,this);
                  break;
               }
               clearPreviewer();
               break;
            case 2:
            case 12:
               _loc3_ = _windowManager.sessionDataManager.getFloorItemData(parseInt(param1.itemTypeId));
               if(_loc3_ == null)
               {
                  clearPreviewer();
                  break;
               }
               imageResult = _windowManager.roomEngine.getFurnitureIcon(_loc3_.id,this);
               break;
            case 3:
               _loc2_ = new class_2198();
               _loc2_.data = _windowManager.catalog.getPixelEffectIcon(parseInt(param1.itemTypeId));
               imageResult = _loc2_;
               break;
            case 5:
               badgeResult = param1.itemTypeId;
               break;
            case 9:
               _loc7_ = parseInt(param1.itemTypeId);
               _loc6_ = class_2085.getIconStyleFor(_loc7_,_windowManager.context.configuration,true);
               if(_loc6_ == 0)
               {
                  clearPreviewer();
                  break;
               }
               iconResult = _loc6_;
               break;
            case 10:
               _loc5_ = parseInt(param1.itemTypeId);
               _loc2_ = new class_2198();
               _loc2_.data = _windowManager.freeFlowChat.chatStyleLibrary.getStyle(_loc5_).selectorPreview;
               imageResult = _loc2_;
               break;
            case 11:
               petResult = param1.petFigureString;
               break;
            default:
               class_21.log("[ProductIconWidget] Can not yet handle this type of product: ");
               clearPreviewer();
         }
      }
      
      public function clearPreviewer() : void
      {
         var_1824 = -1;
         productPreviewBitmap.visible = false;
         badgeImageWidget.visible = false;
         petImageWidget.visible = false;
         unknownImageWindow.visible = false;
         iconWindow.visible = false;
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
      
      private function setUnknownImage() : void
      {
         clearPreviewer();
         unknownImageWindow.visible = true;
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
      
      private function set iconResult(param1:int) : void
      {
         clearPreviewer();
         iconWindow.visible = true;
         iconWindow.style = param1;
         iconWindow.fitToSize();
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
         var_1824 = -1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get productPreviewBitmap() : class_2251
      {
         return var_134.findChildByName("bitmap") as class_2251;
      }
      
      private function get badgeImageWidget() : class_2010
      {
         return var_134.findChildByName("badge_image_widget") as class_2010;
      }
      
      private function get petImageWidget() : class_2010
      {
         return var_134.findChildByName("pet_image_widget") as class_2010;
      }
      
      private function get unknownImageWindow() : IStaticBitmapWrapperWindow
      {
         return var_134.findChildByName("unknown_image") as IStaticBitmapWrapperWindow;
      }
      
      private function get iconWindow() : IIconWindow
      {
         return var_134.findChildByName("icon") as IIconWindow;
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
   }
}

