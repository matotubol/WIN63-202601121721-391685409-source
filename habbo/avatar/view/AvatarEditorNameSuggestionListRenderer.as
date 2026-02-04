package com.sulake.habbo.avatar.view
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.avatar.HabboAvatarEditorManager;
   import flash.geom.Rectangle;
   
   public class AvatarEditorNameSuggestionListRenderer
   {
      
      private const MARGIN_X:int = 5;
      
      private const MARGIN_Y:int = 5;
      
      private var var_52:HabboAvatarEditorManager;
      
      private var _offsetX:int;
      
      private var _offsetY:int;
      
      private var var_5225:int = 0;
      
      private var var_2336:Rectangle = null;
      
      public function AvatarEditorNameSuggestionListRenderer(param1:HabboAvatarEditorManager)
      {
         super();
         this.var_52 = param1;
      }
      
      public function dispose() : void
      {
         var_52 = null;
      }
      
      public function render(param1:Array, param2:class_1812) : int
      {
         var _loc7_:class_1741 = null;
         while(param2.numChildren > 0)
         {
            _loc7_ = param2.removeChildAt(0);
            _loc7_.dispose();
         }
         param2.parent.invalidate();
         var_5225 = 0;
         _offsetX = 0;
         _offsetY = 0;
         var_2336 = param2.rectangle;
         var_2336.height = 150;
         var _loc5_:int = 0;
         while(0 < param1.length)
         {
            var _loc4_:ITextWindow = createItem(param1[0] as String);
            if(fit(null))
            {
               param2.addChild(null);
            }
            else
            {
               null.dispose();
            }
            _loc5_++;
         }
         var _loc6_:int = param2.numChildren;
         if(_loc6_ == 0)
         {
            return 0;
         }
         var _loc3_:class_1741 = param2.getChildAt(param2.numChildren - 1);
         return _loc3_.bottom;
      }
      
      private function fit(param1:class_1741) : Boolean
      {
         if(param1.width > var_2336.width || param1.width < 2)
         {
            return false;
         }
         if(_offsetY + param1.height > var_2336.height)
         {
            return false;
         }
         if(_offsetX + param1.width > var_2336.width)
         {
            _offsetX = 0;
            _offsetY += param1.height + 5;
            return fit(param1);
         }
         param1.x += _offsetX;
         param1.y += _offsetY;
         _offsetX += param1.width + 5;
         return true;
      }
      
      private function createItem(param1:String) : ITextWindow
      {
         var _loc2_:ITextWindow = var_52.windowManager.buildFromXML(XML(HabboAvatarEditorCom.avatar_editor_name_change_item)) as ITextWindow;
         if(_loc2_ == null)
         {
            return null;
         }
         _loc2_.text = param1;
         return _loc2_;
      }
   }
}

