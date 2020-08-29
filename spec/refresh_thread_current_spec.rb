RSpec.describe RefreshThreadCurrent do
  it "has a version number" do
    expect(RefreshThreadCurrent::VERSION).not_to be nil
  end

  describe ".clear_all_local_variables" do
    context "thread local vriable and fiber local variable is stored" do
      before do
        Thread.current.thread_variable_set(:foo, 1)
        Thread.current[:bar] = 2
      end

      it "all local variables be nil" do
        expect(Thread.current.thread_variable_get(:foo)).to eq(1)
        expect(Thread.current[:bar]).to eq(2)

        RefreshThreadCurrent.clear_all_local_variables

        expect(Thread.current.thread_variable_get(:foo)).to eq(nil)
        expect(Thread.current[:bar]).to eq(nil)
      end
    end
  end

  describe ".clear_thread_local_variables" do
    context "thread local vriables is stored" do
      before do
        Thread.current.thread_variable_set(:foo, 1)
        Thread.current.thread_variable_set(:bar, 2)
      end

      it "all local variables be nil" do
        expect(Thread.current.thread_variable_get(:foo)).to eq(1)
        expect(Thread.current.thread_variable_get(:bar)).to eq(2)

        RefreshThreadCurrent.clear_thread_local_variables

        expect(Thread.current.thread_variable_get(:foo)).to eq(nil)
        expect(Thread.current.thread_variable_get(:bar)).to eq(nil)
      end
    end
  end

  describe ".clear_fiber_local_variables" do
    context "fiber local vriables is stored" do
      before do
        Thread.current[:foo] = 1
        Thread.current[:bar] = 2
      end

      it "all local variables be nil" do
        expect(Thread.current[:foo]).to eq(1)
        expect(Thread.current[:bar]).to eq(2)

        RefreshThreadCurrent.clear_fiber_local_variables

        expect(Thread.current[:foo]).to eq(nil)
        expect(Thread.current[:bar]).to eq(nil)
      end
    end
  end
end
