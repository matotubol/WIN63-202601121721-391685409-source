package com.sulake.habbo.roomevents.wired_menu.tabs.tab_inspection
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.utils.class_2201;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.window.widgets.class_2478;
   import com.sulake.habbo.window.widgets.class_3567;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   
   public class VariableHolderPreviewer implements class_1829, class_13
   {
      
      private var _disposed:Boolean;
      
      private var var_1824:Number;
      
      private var _container:class_1812;
      
      private var var_55:WiredMenuController;
      
      private var var_1955:int = 0;
      
      private var var_3166:int = -1;
      
      public function VariableHolderPreviewer(param1:class_1812, param2:WiredMenuController)
      {
         super();
         _container = param1;
         var_55 = param2;
         clearPreviewer();
      }
      
      public static function centerContainer(param1:class_1741) : void
      {
         param1.x = param1.parent.width / 2 - param1.width / 2;
         param1.y = param1.parent.height / 2 - param1.height / 2;
      }
      
      public function clearPreviewer() : void
      {
         var_1955 = 0;
         var_3166 = -1;
         previewFurniInstructionText.visible = false;
         previewUserInstructionText.visible = false;
         previewAvatarWidget.visible = false;
         previewPetWidget.visible = false;
         previewImageBitmap.visible = false;
         previewGlobalPlaceholder.visible = false;
      }
      
      public function setFurniInstructions() : void
      {
         clearPreviewer();
         previewFurniInstructionText.visible = true;
      }
      
      public function setUserInstructions() : void
      {
         clearPreviewer();
         previewUserInstructionText.visible = true;
      }
      
      public function setPreviewByUserIndex(param1:int) : void
      {
         var _loc4_:class_3567 = null;
         var _loc3_:class_2478 = null;
         if(param1 == var_3166)
         {
            return;
         }
         clearPreviewer();
         var _loc2_:class_2146 = var_55.roomEvents.roomSession.userDataManager.getUserDataByIndex(param1);
         if(_loc2_ == null)
         {
            return;
         }
         switch(_loc2_.type - 1)
         {
            case 0:
            case 2:
            case 3:
               previewAvatarWidget.visible = true;
               _loc3_ = previewAvatarWidget.widget as class_2478;
               _loc3_.figure = _loc2_.figure;
               centerContainer(previewAvatarWidget);
               break;
            case 1:
               previewPetWidget.visible = true;
               _loc4_ = previewPetWidget.widget as class_3567;
               _loc4_.figure = _loc2_.figure;
               centerContainer(previewPetWidget);
         }
         var_3166 = param1;
      }
      
      public function setFurniByObjectId(param1:int) : void
      {
         var _loc4_:int = 0;
         if(param1 == var_1955 || -param1 == var_1955)
         {
            return;
         }
         clearPreviewer();
         if(param1 >= 0)
         {
            _loc4_ = 10;
         }
         else
         {
            param1 = -param1;
            _loc4_ = 20;
         }
         var _loc3_:IRoomEngine = var_55.roomEngine;
         var _loc2_:class_2198 = _loc3_.getRoomObjectImage(_loc3_.activeRoomId,param1,_loc4_,new Vector3d(180),64,null);
         if(_loc2_.data != null)
         {
            previewImageBitmap.bitmap = _loc2_.data.clone();
            if(_loc2_.data.width >= _container.width - 6 || _loc2_.data.height > _container.height - 6)
            {
               (previewImageBitmap as class_2201).zoomX = 0.5;
               (previewImageBitmap as class_2201).zoomY = 0.5;
            }
            else
            {
               (previewImageBitmap as class_2201).zoomX = 1;
               (previewImageBitmap as class_2201).zoomY = 1;
            }
            previewImageBitmap.visible = true;
            centerContainer(previewImageBitmap);
         }
         var_1955 = param1;
      }
      
      public function setGlobalPlaceholder() : void
      {
         clearPreviewer();
         previewGlobalPlaceholder.visible = true;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
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
         var_1824 = -1;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get previewFurniInstructionText() : ITextWindow
      {
         return _container.findChildByName("preview_instruction_furni") as ITextWindow;
      }
      
      private function get previewUserInstructionText() : ITextWindow
      {
         return _container.findChildByName("preview_instruction_user") as ITextWindow;
      }
      
      private function get previewAvatarWidget() : class_2010
      {
         return _container.findChildByName("preview_avatar") as class_2010;
      }
      
      private function get previewPetWidget() : class_2010
      {
         return _container.findChildByName("preview_pet") as class_2010;
      }
      
      private function get previewImageBitmap() : class_2251
      {
         return _container.findChildByName("preview_image_bitmap") as class_2251;
      }
      
      private function get previewGlobalPlaceholder() : IStaticBitmapWrapperWindow
      {
         return _container.findChildByName("global_placeholder") as IStaticBitmapWrapperWindow;
      }
   }
}

