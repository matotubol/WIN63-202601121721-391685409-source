package com.sulake.habbo.navigator
{
   import com.sulake.core.window.*;
   import com.sulake.core.window.components.*;
   import com.sulake.core.window.enum.*;
   import com.sulake.core.window.events.*;
   
   public class TagRenderer
   {
      
      private var _navigator:class_42;
      
      private var var_2286:Function;
      
      private var var_3516:Boolean = false;
      
      public function TagRenderer(param1:class_42, param2:Function = null)
      {
         super();
         _navigator = param1;
         var_2286 = param2;
      }
      
      public function dispose() : void
      {
         _navigator = null;
         var_2286 = null;
      }
      
      public function set useHashTags(param1:Boolean) : void
      {
         var_3516 = param1;
      }
      
      public function refreshTags(param1:class_1812, param2:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:class_1812 = class_1812(param1.findChildByName("tags"));
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            refreshTag(_loc3_,_loc4_,param2[_loc4_]);
            _loc4_++;
         }
         var _loc5_:int = param1.width - _loc3_.x;
         Util.layoutChildrenInArea(_loc3_,_loc5_,14);
         _loc3_.height = Util.getLowestPoint(_loc3_);
         _loc3_.visible = param2.length > 0;
      }
      
      public function refreshTag(param1:class_1812, param2:int, param3:String) : void
      {
         var _loc4_:ITextWindow = null;
         var _loc5_:String = "tag." + param2;
         var _loc6_:class_1812 = class_1812(param1.getChildByName(_loc5_));
         if(param3 == null || param3 == "")
         {
            if(_loc6_ != null)
            {
               _loc6_.visible = false;
            }
         }
         else
         {
            if(_loc6_ == null)
            {
               _loc6_ = class_1812(_navigator.getXmlWindow("iro_tag"));
               _loc6_.name = _loc5_;
               param1.addChild(_loc6_);
               _loc6_.procedure = tagProcedure;
            }
            _loc4_ = ITextWindow(_loc6_.findChildByName("txt"));
            _loc4_.text = (var_3516 ? "#" : "") + param3;
            _loc4_.width = _loc4_.textWidth + 5;
            _loc6_.width = _loc4_.width + 3;
            refreshTagBg(_loc6_,false);
            _loc6_.visible = true;
         }
      }
      
      private function refreshTagBg(param1:class_1812, param2:Boolean) : void
      {
         refreshBgPiece(param1,"l",param2);
         refreshBgPiece(param1,"m",param2);
         refreshBgPiece(param1,"r",param2);
      }
      
      private function tagProcedure(param1:class_1758, param2:class_1741) : void
      {
         var _loc5_:class_1812 = param2 as class_1812;
         if(_loc5_ == null)
         {
            return;
         }
         if(param1.type == "WME_OVER")
         {
            refreshTagBg(_loc5_,true);
         }
         else if(param1.type == "WME_OUT")
         {
            refreshTagBg(_loc5_,false);
         }
         else if(param1.type == "WME_CLICK")
         {
            var _loc3_:ITextWindow = ITextWindow(_loc5_.findChildByName("txt"));
            var _loc4_:String = var_3516 ? null.text.substr(1,null.text.length - 1) : null.text;
            class_21.log("TAG CLICKED: " + null);
            _navigator.performTagSearch(null);
            if(var_2286 != null)
            {
               var_2286();
            }
         }
      }
      
      private function refreshBgPiece(param1:class_1812, param2:String, param3:Boolean) : void
      {
         var _loc5_:class_2251 = class_2251(param1.findChildByName("bg_" + param2));
         if(_loc5_.tags[0] != "" + param3)
         {
            _loc5_.tags.splice(0,_loc5_.tags.length);
            _loc5_.tags.push("" + param3);
            var _loc4_:String = "tag_" + param2 + (param3 ? "_reactive" : "");
            _loc5_.bitmap = _navigator.getButtonImage(null);
            _loc5_.disposesBitmap = false;
            _loc5_.invalidate();
         }
      }
   }
}

