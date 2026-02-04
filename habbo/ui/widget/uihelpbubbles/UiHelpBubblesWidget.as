package com.sulake.habbo.ui.widget.uihelpbubbles
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.friendbar.view.class_1962;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.ui.IRoomDesktop;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.chatinput.RoomChatInputWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetScriptProceedMessage;
   import com.sulake.habbo.ui.widget.roomtools.RoomToolsWidget;
   import com.sulake.habbo.window.class_38;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class UiHelpBubblesWidget extends RoomWidgetBase implements ILinkEventTracker
   {
      
      private var var_59:class_17;
      
      private var var_223:class_55;
      
      private var _toolBar:IHabboToolbar;
      
      private var _friendBar:class_1962;
      
      private var _roomTools:RoomToolsWidget;
      
      private var var_4686:RoomChatInputWidget;
      
      private var var_747:Array;
      
      private var var_2222:int = 0;
      
      private var _localization:class_27;
      
      public function UiHelpBubblesWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40, param4:class_27, param5:class_1962, param6:IHabboToolbar, param7:IRoomDesktop, param8:class_17)
      {
         super(param1,param2,param3,param4);
         var_59 = param8;
         _friendBar = param5;
         _toolBar = param6;
         var_223 = new class_55();
         _localization = param4;
         var_747 = [];
         if(param7)
         {
            _roomTools = param7.getWidget("RWE_ROOM_TOOLS") as RoomToolsWidget;
            var_4686 = param7.getWidget("RWE_CHAT_INPUT_WIDGET") as RoomChatInputWidget;
         }
         (param2 as class_17).context.addLinkEventTracker(this);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_223)
         {
            for each(var _loc1_ in var_223)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
            var_223.dispose();
            var_223 = null;
            var_747 = null;
         }
         super.dispose();
      }
      
      private function checkElementPosition(param1:UiHelpBubble, param2:Boolean = false) : Rectangle
      {
         var _loc9_:Rectangle = null;
         var _loc14_:class_1812 = null;
         var _loc5_:class_1741 = null;
         var _loc8_:Array = null;
         var _loc3_:class_1812 = null;
         var _loc10_:ITextFieldWindow = null;
         var _loc13_:Rectangle = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         if(!param1 || !param1.getWindow())
         {
            return null;
         }
         var _loc11_:String = param1.getName();
         if(_loc11_ == "" || !_loc11_)
         {
            return null;
         }
         var _loc15_:int = int(param1.getWindow().height);
         var _loc12_:int = int(param1.getWindow().width);
         var _loc16_:String = "down";
         var _loc17_:int = -1;
         if(toolBar)
         {
            _loc5_ = toolBar.getIcon(_loc11_);
            if(_loc5_)
            {
               _loc9_ = new Rectangle();
               _loc5_.getGlobalRectangle(_loc9_);
               param1.setCallback(_loc5_);
            }
         }
         if(friendBar)
         {
            if(!_loc9_)
            {
               _loc14_ = friendBar.getIconLocation(_loc11_);
               if(_loc14_)
               {
                  _loc9_ = new Rectangle();
                  _loc14_.getGlobalRectangle(_loc9_);
                  param1.setCallback(_loc14_ as class_1741);
               }
            }
         }
         if(!_loc9_)
         {
            if(roomTools)
            {
               _loc5_ = roomTools.getIconLocation(_loc11_);
               if(_loc5_)
               {
                  _loc9_ = new Rectangle();
                  _loc5_.getGlobalRectangle(_loc9_);
                  param1.setCallback(_loc5_);
               }
            }
         }
         if(!_loc9_)
         {
            if(chatInput && _loc11_ == "chat_input")
            {
               _loc8_ = chatInput.getChatInputElements();
               if(_loc8_.length > 1)
               {
                  _loc3_ = _loc8_[0] as class_1812;
                  _loc10_ = _loc8_[1] as ITextFieldWindow;
               }
               _loc9_ = _loc3_.rectangle;
               if(_loc9_)
               {
                  if(param2 && _loc9_)
                  {
                     return _loc9_;
                  }
                  _loc9_.y -= _loc15_ - 40;
                  _loc9_.x += _loc9_.width / 2 - 10;
                  param1.setChatFieldCallback(_loc10_);
                  param1.setArrowPos(_loc16_,_loc17_);
                  return _loc9_;
               }
            }
         }
         if(_loc9_)
         {
            if(param2)
            {
               return _loc9_;
            }
            _loc13_ = _loc9_.clone();
            _loc4_ = 15;
            _loc6_ = int(param1.getWindow().desktop.width);
            if(_loc9_.y - (_loc15_ + _loc4_) < 50)
            {
               _loc4_ = 0;
            }
            _loc16_ = "down";
            _loc17_ = 0;
            _loc9_.x += _loc9_.width / 2;
            _loc9_.y -= _loc15_ + _loc4_;
            var _loc7_:int = _loc9_.right - _loc13_.right;
            if(_loc7_ >= _loc12_ / 2)
            {
               _loc7_ = _loc12_ / 2 - 25;
            }
            if(_loc9_.y < _loc15_)
            {
               _loc9_.y += _loc9_.height + _loc15_ + 10;
               _loc16_ = "up";
               _loc7_ = 0 / 3;
               _loc17_ = 0;
               param1.setArrowPos(_loc16_,_loc17_);
            }
            if(_loc9_.x < _loc12_ / 2)
            {
               _loc9_.x = 10;
               _loc17_ -= _loc12_ / 2 - 30;
               param1.setArrowPos(_loc16_,_loc17_);
               return _loc9_;
            }
            if(_loc9_.x + _loc12_ / 2 > _loc6_)
            {
               _loc9_.x = _loc6_ - _loc12_ / 2;
               _loc17_ = _loc12_ / 4;
               param1.setArrowPos(_loc16_,_loc17_);
               return _loc9_;
            }
            param1.setArrowPos(_loc16_,_loc17_);
         }
         return _loc9_;
      }
      
      public function addNextBubble() : void
      {
         if(!var_747 || var_747.length == 0 || var_747.length < var_2222 + 1)
         {
            return;
         }
         var _loc3_:HelpBubbleItem = var_747[var_2222] as HelpBubbleItem;
         var _loc2_:* = var_747.length > var_2222 + 1;
         var _loc6_:String = _loc3_.name;
         var _loc4_:UiHelpBubble = new UiHelpBubble(this,_loc3_,_loc2_);
         if(var_223.hasKey(_loc6_))
         {
            removeHelpBubble(_loc6_);
         }
         var _loc1_:Rectangle = checkElementPosition(_loc4_);
         var_2222 = var_2222 + 1;
         if(_loc1_)
         {
            var _loc5_:Point = new Point(_loc1_.x,_loc1_.y);
         }
         _loc4_.dispose();
         addNextBubble();
      }
      
      private function addHelpBubble(param1:String, param2:UiHelpBubble) : void
      {
         if(!var_223 || !param2)
         {
            return;
         }
         var_223.add(param1,param2);
      }
      
      public function removeHelpBubble(param1:String) : void
      {
         if(!var_223)
         {
            return;
         }
         var _loc2_:UiHelpBubble = var_223.getValue(param1) as UiHelpBubble;
         if(!_loc2_)
         {
            return;
         }
         var_223.remove(param1);
         _loc2_.dispose();
         addNextBubble();
      }
      
      private function onDesktopResized(param1:class_1758 = null) : void
      {
         var _loc2_:Rectangle = null;
         for each(var _loc3_ in var_223)
         {
            _loc2_ = checkElementPosition(_loc3_);
            if(_loc2_)
            {
               var _loc4_:Point = new Point(_loc2_.x,_loc2_.y);
               _loc3_.setPosition(null);
               _loc3_.setModal(checkElementPosition(_loc3_,true));
            }
         }
      }
      
      public function sendScriptProceedMessage() : void
      {
         var _loc1_:RoomWidgetMessage = new RoomWidgetScriptProceedMessage("RWPM_ANSWER");
         if(messageListener)
         {
            messageListener.processWidgetMessage(_loc1_);
         }
      }
      
      public function get linkPattern() : String
      {
         return "helpBubble/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc8_:int = 0;
         var _loc3_:HelpBubbleItem = null;
         var _loc7_:int = 0;
         var _loc6_:String = null;
         var _loc4_:String = null;
         if(!var_223)
         {
            var_223 = new class_55();
         }
         if(!var_747)
         {
            var_747 = [];
         }
         var _loc2_:Array = param1.split("/");
         var _loc5_:int = int(_loc2_.length);
         if(_loc5_ < 3)
         {
            return;
         }
         if(_loc2_[1] == "add")
         {
            _loc8_ = 0;
            _loc7_ = 2;
            while(_loc7_ < _loc5_)
            {
               if(++_loc8_ == 1)
               {
                  _loc3_ = new HelpBubbleItem();
                  _loc6_ = _loc2_[_loc7_];
                  _loc4_ = UiHelpBubbleIconEnum[_loc6_];
                  if(!_loc4_)
                  {
                     _loc4_ = _loc6_;
                  }
                  _loc3_.name = _loc4_;
                  _loc3_.modal = true;
               }
               if(_loc8_ == 2)
               {
                  _loc3_.text = _localization.getLocalization(_loc2_[_loc7_],_loc2_[_loc7_]);
                  _loc8_ = 0;
                  var_747.push(_loc3_);
               }
               _loc7_++;
            }
            addNextBubble();
         }
         else if(_loc2_[1] == "remove")
         {
            removeHelpBubble(_loc2_[2]);
         }
      }
      
      public function get toolBar() : IHabboToolbar
      {
         return _toolBar;
      }
      
      public function get friendBar() : class_1962
      {
         return _friendBar;
      }
      
      public function get roomTools() : RoomToolsWidget
      {
         return _roomTools;
      }
      
      public function get chatInput() : RoomChatInputWidget
      {
         return var_4686;
      }
   }
}

