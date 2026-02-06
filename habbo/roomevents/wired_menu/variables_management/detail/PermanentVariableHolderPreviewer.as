package com.sulake.habbo.roomevents.wired_menu.variables_management.detail
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import com.sulake.habbo.window.widgets.class_2478;
   import com.sulake.habbo.window.widgets.class_3567;
   import flash.display.BitmapData;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   
   public class PermanentVariableHolderPreviewer implements class_1829, class_13
   {
      
      private var _disposed:Boolean;
      
      private var _container:class_1812;
      
      private var var_55:WiredMenuController;
      
      private var var_1270:int;
      
      public function PermanentVariableHolderPreviewer(param1:class_1812, param2:WiredMenuController)
      {
         super();
         _container = param1;
         var_55 = param2;
         clearPreviewer();
         previewAvatarRegion.addEventListener("WME_CLICK",onPreviewAvatarClicked);
      }
      
      public static function centerContainer(param1:class_1741) : void
      {
         param1.x = param1.parent.width / 2 - param1.width / 2;
         param1.y = param1.parent.height / 2 - param1.height / 2;
      }
      
      private function onPreviewAvatarClicked(param1:WindowMouseEvent) : void
      {
         var_55.send(new GetExtendedProfileMessageComposer(var_1270,true));
      }
      
      public function clearPreviewer() : void
      {
         previewAvatarWidget.visible = false;
         previewPetWidget.visible = false;
      }
      
      public function setPetPreview(param1:String) : void
      {
         clearPreviewer();
         previewPetWidget.visible = true;
         var _loc2_:class_3567 = previewPetWidget.widget as class_3567;
         _loc2_.figure = param1;
         centerContainer(previewPetWidget);
      }
      
      public function setUserPreview(param1:String, param2:int = -1) : void
      {
         clearPreviewer();
         previewAvatarWidget.visible = true;
         var _loc3_:class_2478 = previewAvatarWidget.widget as class_2478;
         _loc3_.figure = param1;
         centerContainer(previewAvatarWidget);
         var_1270 = param2;
         previewAvatarRegion.visible = param2 != -1;
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
         var_1270 = -1;
         _container = null;
         var_55 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get previewAvatarWidget() : class_2010
      {
         return _container.findChildByName("avatar_preview") as class_2010;
      }
      
      private function get previewAvatarRegion() : IRegionWindow
      {
         return _container.findChildByName("avatar_preview_region") as IRegionWindow;
      }
      
      private function get previewPetWidget() : class_2010
      {
         return _container.findChildByName("pet_preview") as class_2010;
      }
   }
}

