package com.sulake.habbo.avatar.figuredata
{
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.room.preview.RoomPreviewer;
   import com.sulake.habbo.window.widgets.IRoomPreviewerWidget;
   
   public class FigureDataView implements class_259
   {
      
      public static const PREVIEW_AVATAR_DIRECTION:int = 4;
      
      private var var_16:IRoomPreviewerWidget;
      
      private var var_281:RoomPreviewer;
      
      private var var_36:FigureData;
      
      private var _figureString:String;
      
      private var var_1134:Boolean;
      
      public function FigureDataView(param1:FigureData)
      {
         super();
         var_36 = param1;
         var_16 = param1.avatarEditor.view.getFigureContainer().widget as IRoomPreviewerWidget;
         var_281 = var_16.roomPreviewer;
         var_281.updateRoomWallsAndFloorVisibility(false,false);
      }
      
      public function update(param1:String, param2:int = 0, param3:int = 4) : void
      {
         _figureString = param1;
         if(var_281.isRoomEngineReady)
         {
            var_281.addAvatarIntoRoom(param1,param2);
            var_281.updateAvatarDirection(param3,param3);
            var_281.updatePreviewRoomView(true);
            var_281.updateRoomEngine();
         }
         else
         {
            var _loc4_:class_1827 = var_36.avatarEditor.manager.avatarRenderManager.createAvatarImage(param1,"h",null,this);
            var_16.showPreview(null.getCroppedImage("full"));
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(param1 == _figureString)
         {
            var _loc2_:class_1827 = var_36.avatarEditor.manager.avatarRenderManager.createAvatarImage(param1,"h",null,this);
            var_16.showPreview(null.getCroppedImage("full"));
         }
      }
      
      public function dispose() : void
      {
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
   }
}

