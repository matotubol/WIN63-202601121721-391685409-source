package com.sulake.habbo.ui.widget.messages
{
   import com.sulake.core.window.class_1812;
   
   public class RoomWidgetAvatarEditorMessage extends RoomWidgetMessage
   {
      
      public static const const_572:String = "RWCM_OPEN_AVATAR_EDITOR";
      
      public static const WIDGET_MESSAGE_GET_WARDROBE:String = "RWCM_GET_WARDROBE";
      
      public static const const_647:String = "RWAEM_AVATAR_EDITOR_VIEW_DISPOSED";
      
      private var _context:class_1812;
      
      public function RoomWidgetAvatarEditorMessage(param1:String, param2:class_1812 = null)
      {
         super(param1);
         _context = param2;
      }
      
      public function get context() : class_1812
      {
         return _context;
      }
   }
}

