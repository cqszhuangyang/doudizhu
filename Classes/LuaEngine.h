#pragma once
extern "C" {
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"
}

#include "cocos2d.h"
#include "Lua_extensions_CCB.h"
class LuaEngine
{
public:
	LuaEngine();
	~LuaEngine();
	void init();
	static LuaEngine* shareLuaEngine();
	void callFunction();
	void readVariable();

private:

	static LuaEngine* instance;
	lua_State* m_luaState;
};

