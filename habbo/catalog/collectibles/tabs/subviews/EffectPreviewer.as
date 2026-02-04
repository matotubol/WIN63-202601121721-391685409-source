package com.sulake.habbo.catalog.collectibles.tabs.subviews
{
   import com.sulake.core.window.components.class_2010;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.room.preview.RoomPreviewer;
   import com.sulake.habbo.window.widgets.IRoomPreviewerWidget;
   
   public class EffectPreviewer implements class_259
   {
      
      private static var var_5222:int = 2;
      
      private var var_119:class_2010;
      
      private var _avatarRenderManager:class_48;
      
      private var var_1134:Boolean;
      
      public function EffectPreviewer(param1:class_2010, param2:class_48)
      {
         super();
         var_119 = param1;
         _avatarRenderManager = param2;
         roomPreviewer.updateRoomWallsAndFloorVisibility(false,false);
      }
      
      public function update(param1:String, param2:int) : void
      {
         var _loc3_:class_1827 = null;
         var _loc4_:RoomPreviewer = roomPreviewer;
         if(_loc4_.isRoomEngineReady)
         {
            _loc4_.addAvatarIntoRoom(param1,param2);
            _loc4_.updateAvatarDirection(var_5222,var_5222);
            _loc4_.updatePreviewRoomView(true);
            _loc4_.updateRoomEngine();
         }
         else
         {
            _loc3_ = _avatarRenderManager.createAvatarImage(param1,"h",null,this);
            widget.showPreview(_loc3_.getCroppedImage("full"));
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(!var_1134)
         {
            var _loc2_:class_1827 = _avatarRenderManager.createAvatarImage(param1,"h",null,this);
            widget.showPreview(null.getCroppedImage("full"));
         }
      }
      
      public function dispose() : void
      {
         if(var_1134)
         {
            return;
         }
         var_1134 = true;
         roomPreviewer.reset(true);
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      private function get widget() : IRoomPreviewerWidget
      {
         return var_119.widget as IRoomPreviewerWidget;
      }
      
      private function get roomPreviewer() : RoomPreviewer
      {
         return widget.roomPreviewer;
      }
      
      public function set visible(param1:Boolean) : void
      {
         var_119.visible = param1;
      }
   }
}

