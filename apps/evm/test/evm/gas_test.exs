defmodule EVM.GasTest do
  use ExUnit.Case, async: true
  doctest EVM.Gas
  alias EVM.MachineCode
  alias EVM.MachineState
  alias EVM.ExecEnv
  alias EVM.Gas
  alias EVM.Interface.Mock.MockAccountInterface

  test "Gas cost: CALL" do
    to_address = 0x0F572E5295C57F15886F9B263E2F6D2D6C7B5EC6
    inputs = [3000, to_address, 0, 0, 32, 32, 32]
    machine_state = %MachineState{program_counter: 0, stack: inputs}
    account_interface = MockAccountInterface.new()

    exec_env = %ExecEnv{
      machine_code: MachineCode.compile([:call]),
      address: to_address,
      account_interface: account_interface
    }

    cost = Gas.cost(machine_state, exec_env)

    assert cost == 28046
  end
end
