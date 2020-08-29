RSpec.describe RefreshThreadCurrent::Middleware do
  class DummyRackApp
    def call(_env); end
  end

  describe 'use middleware with rack request' do
    before do
      @app = DummyRackApp.new
      @middleware = RefreshThreadCurrent::Middleware.new(@app)
    end

    context "thread local vriable and fiber local variable is stored" do
      before do
        Thread.current.thread_variable_set(:foo, 1)
        Thread.current[:bar] = 2
      end

      it 'all local variables be nil after the end of request' do
        expect(Thread.current.thread_variable_get(:foo)).to eq(1)
        expect(Thread.current[:bar]).to eq(2)

        @middleware.call({})

        expect(Thread.current.thread_variable_get(:foo)).to eq(nil)
        expect(Thread.current[:bar]).to eq(nil)
      end
    end

    context "raise Exception in middleware" do
      context "thread local vriable and fiber local variable is stored" do
        before do
          Thread.current.thread_variable_set(:foo, 1)
          Thread.current[:bar] = 2
        end

        it 'all local variables be nil after the end of request' do
          allow(@app).to receive(:call).and_raise(Exception)
          
          expect(Thread.current.thread_variable_get(:foo)).to eq(1)
          expect(Thread.current[:bar]).to eq(2)

          expect{ @middleware.call({}) }.to raise_error(Exception)

          expect(Thread.current.thread_variable_get(:foo)).to eq(nil)
          expect(Thread.current[:bar]).to eq(nil)
        end
      end
    end
  end
end
